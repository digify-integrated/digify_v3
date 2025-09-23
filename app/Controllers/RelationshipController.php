<?php
namespace App\Controllers;


session_start();

use App\Models\Relationship;
use App\Models\Authentication;
use App\Core\Security;
use App\Helpers\SystemHelper;

require_once '../../config/config.php';

class RelationshipController
{
    protected Relationship $relationship;
    protected Authentication $authentication;
    protected Security $security;
    protected SystemHelper $systemHelper;

    public function __construct(
        Relationship $relationship,
        Authentication $authentication,
        Security $security,
        SystemHelper $systemHelper
    ) {
        $this->relationship     = $relationship;
        $this->authentication   = $authentication;
        $this->security         = $security;
        $this->systemHelper     = $systemHelper;
    }

    public function handleRequest(): void
    {
        if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Only POST requests are allowed.'
            );
        }

        $transaction    = $_POST['transaction'] ?? null;
        $lastLogBy      = $_SESSION['user_account_id'];

        if (!$transaction) {
            $this->systemHelper::sendErrorResponse(
                'Missing Transaction',
                'No transaction type was provided.'
            );
        }

        $loginCredentialsDetails    = $this->authentication->fetchLoginCredentials($lastLogBy);       
        $multipleSession            = $loginCredentialsDetails['multiple_session'] ?? 'No';
        $isActive                   = $loginCredentialsDetails['active'] ?? 'No';

        $sessionTokenDetails    = $this->authentication->fetchSession($lastLogBy);
        $sessionToken           = $sessionTokenDetails['session_token'] ?? '';

        if ($isActive === 'No' || (!$this->security->verifyToken($_SESSION['session_token'], $sessionToken) && $multipleSession === 'No')) {
            $this->systemHelper::sendErrorResponse(
                'Session Expired', 
                'Your session has expired. Please log in again to continue.',
                [
                    'invalid_session' => true,
                    'redirect_link' => 'logout.php?logout'
                ]
            );
        }

        $transaction = strtolower(trim($transaction));

        match ($transaction) {
            'save relationship'                 => $this->saveRelationship($lastLogBy),
            'delete relationship'               => $this->deleteRelationship(),
            'delete multiple relationship'      => $this->deleteMultipleRelationship(),
            'fetch relationship details'        => $this->fetchRelationshipDetails(),
            'generate relationship table'       => $this->generateRelationshipTable(),
            'generate relationship options'     => $this->generateRelationshipOptions(),
            default                             => $this->systemHelper::sendErrorResponse(
                                                        'Transaction Failed',
                                                        'We encountered an issue while processing your request.'
                                                    )
        };
    }

    public function saveRelationship($lastLogBy){
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'relationship_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $relationshipId      = $_POST['relationship_id'] ?? null;
        $relationshipName    = $_POST['relationship_name'] ?? null;

        $relationshipId           = $this->relationship->saveRelationship($relationshipId, $relationshipName, $lastLogBy);
        $encryptedRelationshipId  = $this->security->encryptData($relationshipId);

        $this->systemHelper->sendSuccessResponse(
            'Save Relationship Success',
            'The relationship has been saved successfully.',
            ['relationship_id' => $encryptedRelationshipId]
        );
    }

    public function deleteRelationship(){
        $relationshipId = $_POST['relationship_id'] ?? null;

        $this->relationship->deleteRelationship($relationshipId);

        $this->systemHelper->sendSuccessResponse(
            'Delete Relationship Success',
            'The relationship has been deleted successfully.'
        );
    }

    public function deleteMultipleRelationship(){
        $relationshipIds = $_POST['relationship_id'] ?? null;

        foreach($relationshipIds as $relationshipId){
            $this->relationship->deleteRelationship($relationshipId);
        }

        $this->systemHelper->sendSuccessResponse(
            'Delete Multiple Relationships Success',
            'The selected relationships have been deleted successfully.'
        );
    }

    public function fetchRelationshipDetails(){
        $relationshipId             = $_POST['relationship_id'] ?? null;
        $checkRelationshipyExist    = $this->relationship->checkRelationshipExist($relationshipId);
        $total                      = $checkRelationshipyExist['total'] ?? 0;

        if($total === 0){
            $this->systemHelper->sendErrorResponse(
                'Get Relationship Details',
                'The relationship does not exist',
                ['notExist' => true]
            );
        }

        $relationshipDetails = $this->relationship->fetchRelationship($relationshipId);

        $response = [
            'success'           => true,
            'relationshipName'  => $relationshipDetails['relationship_name'] ?? null
        ];

        echo json_encode($response);
        exit;
    }

    public function generateRelationshipTable()
    {
        $pageLink   = $_POST['page_link'] ?? null;
        $response   = [];

        $countries = $this->relationship->generateRelationshipTable();

        foreach ($countries as $row) {
            $relationshipId      = $row['relationship_id'];
            $relationshipName    = $row['relationship_name'];

            $relationshipIdEncrypted = $this->security->encryptData($relationshipId);

            $response[] = [
                'CHECK_BOX'             => '<div class="form-check form-check-sm form-check-custom form-check-solid me-3">
                                                <input class="form-check-input datatable-checkbox-children" type="checkbox" value="'. $relationshipId .'">
                                            </div>',
                'RELATIONSHIP_NAME'     => $relationshipName,
                'LINK'                  => $pageLink .'&id='. $relationshipIdEncrypted
            ];
        }

        echo json_encode($response);
    }
    
    public function generateRelationshipOptions()
    {
        $multiple   = $_POST['multiple'] ?? false;
        $response   = [];

        if(!$multiple){
            $response[] = [
                'id'    => '',
                'text'  => '--'
            ];
        }

        $countries = $this->relationship->generateRelationshipOptions();

        foreach ($countries as $row) {
            $response[] = [
                'id'    => $row['relationship_id'],
                'text'  => $row['relationship_name']
            ];
        }

        echo json_encode($response);
    }
}

# Bootstrap the controller
$controller = new RelationshipController(
    new Relationship(),
    new Authentication(),
    new Security(),
    new SystemHelper()
);

$controller->handleRequest();
