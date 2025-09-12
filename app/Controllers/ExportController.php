<?php
namespace App\Controllers;

session_start();

use App\Models\Export;
use App\Core\Security;
use App\Helpers\SystemHelper;
use PhpOffice\PhpSpreadsheet\Spreadsheet;
use PhpOffice\PhpSpreadsheet\Writer\Xlsx;

require_once '../../config/config.php';

class ExportController
{
    protected Export $export;
    protected Security $security;
    protected SystemHelper $systemHelper;

    public function __construct(
        Export $export,
        Security $security,
        SystemHelper $systemHelper
    ) {
        $this->export               = $export;
        $this->security             = $security;
        $this->systemHelper         = $systemHelper;
    }

    public function handleRequest(): void
    {
        if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
            $this->systemHelper::sendErrorResponse('Invalid Request', 'Only POST requests are allowed.');
            return;
        }

        $transaction = $_POST['transaction'] ?? null;

        if (!$transaction) {
            $this->systemHelper::sendErrorResponse('Missing Transaction', 'No transaction type was provided.');
            return;
        }

        $transaction = strtolower(trim($transaction));

        match ($transaction) {
            'generate export column option'     => $this->generateExportColumnOption(),
            'generate export table options'     => $this->generateExportTableOption(),
            'export data'                       => $this->exportData(),
            default                             => $this->systemHelper::sendErrorResponse(
                'Transaction Failed',
                'We encountered an issue while processing your request.'
            ),
        };
    }

    public function generateExportColumnOption()
    {
        $tableName = isset($_POST['table_name']) ? $_POST['table_name'] : null;
        $response = [];

        $exports = $this->export->generateExportOption(DB_NAME, $tableName);

        foreach ($exports as $row) {
            $response[] = [
                'id'    => $row['column_name'],
                'text'  => $row['column_name']
            ];
        }

        echo json_encode($response);
    }

    public function generateExportTableOption()
    {
        $multiple = isset($_POST['multiple']) ? $_POST['multiple'] : false;
        $response = [];

        if(!$multiple){
            $response[] = [
                'id'    => '',
                'text'  => '--'
            ];
        }

        $exports = $this->export->generateTableOption(DB_NAME);

        foreach ($exports as $row) {
            $response[] = [
                'id'    => $row['table_name'],
                'text'  => $row['table_name']
            ];
        }

        echo json_encode($response);
    }

    public function exportData()
    {
        $exportTo       = isset($_POST['export_to']) ? $_POST['export_to'] : null;
        $exportIDs      = isset($_POST['export_id']) ? $_POST['export_id'] : null;
        $tableColumns   = isset($_POST['table_column']) ? $_POST['table_column'] : null;
        $tableName      = isset($_POST['table_name']) ? $_POST['table_name'] : null;

        $cleanTableName = preg_replace('/[^a-zA-Z0-9_-]/', '_', strtolower($tableName));
        $timestamp = date('Y-m-d_Hi');
        

        if ($exportTo === 'csv') {
            $filename = "{$cleanTableName}_report_{$timestamp}.csv";
            
            header('Content-Type: text/csv');
            header('Content-Disposition: attachment; filename="' . $filename . '"');
                
            $output = fopen('php://output', 'w');

            fputcsv($output, $tableColumns);
                
            $columns = implode(", ", $tableColumns);
                
            $ids                = implode(",", array_map('intval', $exportIDs));
            $appModuleDetails   = $this->export->fetchExportData($tableName, $columns, $ids);

            foreach ($appModuleDetails as $appModuleDetail) {
                fputcsv($output, $appModuleDetail);
            }

            fclose($output);
            exit;
        }
        else {
            ob_start();
            $filename = "{$cleanTableName}_report_{$timestamp}.xlsx";

            $spreadsheet = new Spreadsheet();
            $sheet = $spreadsheet->getActiveSheet();

            $colIndex = 'A';
            foreach ($tableColumns as $column) {
                $sheet->setCellValue($colIndex . '1', ucfirst(str_replace('_', ' ', $column)));
                $colIndex++;
            }

            $columns = implode(", ", $tableColumns);
                
            $ids                = implode(",", array_map('intval', $exportIDs));
            $appModuleDetails   = $this->export->fetchExportData($tableName, $columns, $ids);

            $rowNumber = 2;
            foreach ($appModuleDetails as $appModuleDetail) {
                $colIndex = 'A';
                foreach ($tableColumns as $column) {
                    $sheet->setCellValue($colIndex . $rowNumber, $appModuleDetail[$column]);
                    $colIndex++;
                }
                $rowNumber++;
            }

            ob_end_clean();

            header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
            header('Content-Disposition: attachment; filename="' . $filename . '"');
            header('Cache-Control: max-age=0');

            $writer = new Xlsx($spreadsheet);
            $writer->save('php://output');
            exit;
        }
    }
}

# Bootstrap the controller
$controller = new ExportController(
    new Export(),
    new Security(),
    new SystemHelper()
);

$controller->handleRequest();
