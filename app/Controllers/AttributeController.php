<?php
namespace App\Controllers;


session_start();

use App\Models\Attribute;
use App\Models\Authentication;
use App\Core\Security;
use App\Helpers\SystemHelper;

require_once '../../config/config.php';

class AttributeController
{
    protected Attribute $attribute;
    protected Authentication $authentication;
    protected Security $security;
    protected SystemHelper $systemHelper;

    public function __construct(
        Attribute $attribute,
        Authentication $authentication,
        Security $security,
        SystemHelper $systemHelper
    ) {
        $this->attribute        = $attribute;
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
        $pageId         = $_POST['page_id'] ?? null;
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
            'save attribute'                    => $this->saveAttribute($lastLogBy),
            'save attribute value'              => $this->saveAttributeValue($lastLogBy),
            'delete attribute'                  => $this->deleteAttribute(),
            'delete multiple attribute'         => $this->deleteMultipleAttribute(),
            'delete attribute value'            => $this->deleteAttributeValue(),
            'fetch attribute details'           => $this->fetchAttributeDetails(),
            'fetch attribute value details'     => $this->fetchAttributeValueDetails(),
            'generate attribute table'          => $this->generateAttributeTable(),
            'generate attribute value table'    => $this->generateAttributeValueTable($lastLogBy, $pageId),
            'generate attribute options'        => $this->generateAttributeOptions(),
            'generate attribute value options'  => $this->generateAttributeValueOptions(),
            default                             => $this->systemHelper::sendErrorResponse(
                                                    'Transaction Failed',
                                                    'We encountered an issue while processing your request.'
                                                )
        };
    }

    public function saveAttribute($lastLogBy){
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'attribute_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $attributeId            = $_POST['attribute_id'] ?? null;
        $attributeName          = $_POST['attribute_name'] ?? null;
        $attributeDescription   = $_POST['attribute_description'] ?? null;
        $variantCreation        = $_POST['variant_creation'] ?? null;
        $displayType            = $_POST['display_type'] ?? null;

        $attributeId           = $this->attribute->saveAttribute($attributeId, $attributeName, $attributeDescription, $variantCreation, $displayType, $lastLogBy);
        $encryptedAttributeId  = $this->security->encryptData($attributeId);

        $this->systemHelper->sendSuccessResponse(
            'Save Attribute Success',
            'The attribute has been saved successfully.',
            ['attribute_id' => $encryptedAttributeId]
        );
    }

    public function saveAttributeValue($lastLogBy){
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'attribute_value_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $attributeId            = $_POST['attribute_id'] ?? null;
        $attributeValueId       = $_POST['attribute_value_id'] ?? null;
        $attributeValueName     = $_POST['attribute_value_name'] ?? null;

        $attributeDetails   = $this->attribute->fetchAttribute($attributeId);
        $attributeName      = $attributeDetails['attribute_name'] ?? '';

        $this->attribute->saveAttributeValue($attributeValueId, $attributeValueName, $attributeId, $attributeName, $lastLogBy);

        $this->systemHelper->sendSuccessResponse(
            'Save Attribute Value Success',
            'The attribute value has been saved successfully.'
        );
    }

    public function deleteAttribute(){
        $attributeId = $_POST['attribute_id'] ?? null;

        $this->attribute->deleteAttribute($attributeId);

        $this->systemHelper->sendSuccessResponse(
            'Delete Attribute Success',
            'The attribute has been deleted successfully.'
        );
    }

    public function deleteMultipleAttribute(){
        $attributeIds = $_POST['attribute_id'] ?? null;

        foreach($attributeIds as $attributeId){
            $this->attribute->deleteAttribute($attributeId);
        }

        $this->systemHelper->sendSuccessResponse(
            'Delete Multiple Attributes Success',
            'The selected attributes have been deleted successfully.'
        );
    }

    public function deleteAttributeValue(){
        $attributeValueId = $_POST['attribute_value_id'] ?? null;

        $this->attribute->deleteAttributeValue($attributeValueId);

        $this->systemHelper->sendSuccessResponse(
            'Delete Attribute Value Success',
            'The attribute value has been deleted successfully.'
        );
    }

    public function fetchAttributeDetails(){
        $attributeId            = $_POST['attribute_id'] ?? null;
        $checkAttributeExist    = $this->attribute->checkAttributeExist($attributeId);
        $total                  = $checkAttributeExist['total'] ?? 0;

        if($total === 0){
            $this->systemHelper->sendErrorResponse(
                'Get Attribute Details',
                'The attribute does not exist',
                ['notExist' => true]
            );
        }

        $attributeDetails = $this->attribute->fetchAttribute($attributeId);

        $response = [
            'success'               => true,
            'attributeName'         => $attributeDetails['attribute_name'] ?? null,
            'attributeDescription'  => $attributeDetails['attribute_description'] ?? null,
            'variantCreation'       => $attributeDetails['variant_creation'] ?? null,
            'displayType'           => $attributeDetails['display_type'] ?? null,
        ];

        echo json_encode($response);
        exit;
    }

    public function fetchAttributeValueDetails(){
        $attributeValueId           = $_POST['attribute_value_id'] ?? null;
        $checkAttributeValueExist   = $this->attribute->checkAttributeValueExist($attributeValueId);
        $total                      = $checkAttributeValueExist['total'] ?? 0;

        if($total === 0){
            $this->systemHelper->sendErrorResponse(
                'Get Attribute Value Details',
                'The attribute value does not exist',
                ['notExist' => true]
            );
        }

        $attributeDetails = $this->attribute->fetchAttributeValue($attributeValueId);

        $response = [
            'success'               => true,
            'attributeValueName'    => $attributeDetails['attribute_value_name'] ?? null
        ];

        echo json_encode($response);
        exit;
    }

    public function generateAttributeTable()
    {
        $pageLink               = $_POST['page_link'] ?? null;
        $variantCreationFilter  = $this->systemHelper->checkFilter($_POST['variant_creation_filter'] ?? null);
        $displayTypeFilter      = $this->systemHelper->checkFilter($_POST['display_type_filter'] ?? null);
        $response               = [];

        $attributes = $this->attribute->generateAttributeTable($variantCreationFilter, $displayTypeFilter);

        foreach ($attributes as $row) {
            $attributeId            = $row['attribute_id'];
            $attributeName          = $row['attribute_name'];
            $attributeDescription   = $row['attribute_description'];
            $variantCreation        = $row['variant_creation'];
            $displayType            = $row['display_type'];
            $attributeIdEncrypted   = $this->security->encryptData($attributeId);

            $response[] = [
                'CHECK_BOX'         => '<div class="form-check form-check-sm form-check-custom form-check-solid me-3">
                                            <input class="form-check-input datatable-checkbox-children" type="checkbox" value="'. $attributeId .'">
                                        </div>',
                'ATTRIBUTE_NAME'    => '<div class="d-flex flex-column">
                                            <span class="text-gray-800 fw-bold mb-1">'. $attributeName .'</span>
                                            <small class="text-gray-600">'. $attributeDescription .'</small>
                                        </div>',
                'VARIANT_CREATION'  => $variantCreation,
                'DISPLAY_TYPE'      => $displayType,
                'LINK'              => $pageLink .'&id='. $attributeIdEncrypted
            ];
        }

        echo json_encode($response);
    }

    public function generateAttributeValueTable($lastLogBy, $pageId)
    {
        $attributeId    = $_POST['attribute_id'] ?? null;
        $response       = [];

        $writeAccess        = $this->authentication->checkUserPermission($lastLogBy, $pageId, 'write')['total'] ?? 0;
        $logNotesAccess     = $this->authentication->checkUserPermission($lastLogBy, $pageId, 'log notes')['total'] ?? 0;

        $attributeValues = $this->attribute->generateAttributeValueTable($attributeId);

        foreach ($attributeValues as $row) {
            $attributeValueId       = $row['attribute_value_id'];
            $attributeValueName     = $row['attribute_value_name'];

            $button = '';
            if($writeAccess > 0){
                $button = '<button class="btn btn-icon btn-light btn-active-light-primary update-attribute-value" data-attribute-value-id="' . $attributeValueId . '" data-bs-toggle="modal" data-bs-target="#attribute_value_modal" title="View Log Notes">
                                    <i class="ki-outline ki-pencil fs-3 m-0 fs-5"></i>
                                </button>
                <button class="btn btn-icon btn-light btn-active-light-danger delete-attribute-value" data-attribute-value-id="' . $attributeValueId . '">
                                 <i class="ki-outline ki-trash fs-3 m-0 fs-5"></i>
                            </button>';
            }

            $logNotes = '';
            if($logNotesAccess > 0){
                $logNotes = '<button class="btn btn-icon btn-light btn-active-light-primary view-attribute-value-log-notes" data-attribute-value-id="' . $attributeValueId . '" data-bs-toggle="modal" data-bs-target="#log-notes-modal" title="View Log Notes">
                                    <i class="ki-outline ki-shield-search fs-3 m-0 fs-5"></i>
                                </button>';
            }

            $response[] = [
                'ATTRIBUTE_VALUE'   => $attributeValueName,
                'ACTION'            => '<div class="d-flex justify-content-end gap-3">
                                            '. $logNotes .'
                                            '. $button .'
                                        </div>'
            ];
        }

        echo json_encode($response);
    }
    
    public function generateAttributeOptions()
    {
        $multiple   = $_POST['multiple'] ?? false;
        $response   = [];

        if(!$multiple){
            $response[] = [
                'id'    => '',
                'text'  => '--'
            ];
        }

        $attributes = $this->attribute->generateAttributeOptions();

        foreach ($attributes as $row) {
            $response[] = [
                'id'    => $row['attribute_id'],
                'text'  => $row['attribute_name']
            ];
        }

        echo json_encode($response);
    }
    
    public function generateAttributeValueOptions()
    {
        $multiple   = $_POST['multiple'] ?? false;
        $response   = [];

        if(!$multiple){
            $response[] = [
                'id'    => '',
                'text'  => '--'
            ];
        }

        $attributeValues = $this->attribute->generateAttributeValueOptions();

        $grouped = [];
        foreach ($attributeValues as $row) {
            $grouped[$row['attribute_name']][] = [
                'id'   => $row['attribute_value_id'],
                'text' => $row['attribute_value_name']
            ];
        }

        foreach ($grouped as $attributeName => $children) {
            $response[] = [
                'text'     => $attributeName,
                'children' => $children
            ];
        }

        echo json_encode($response);
    }
}

# Bootstrap the controller
$controller = new AttributeController(
    new Attribute(),
    new Authentication(),
    new Security(),
    new SystemHelper()
);

$controller->handleRequest();
