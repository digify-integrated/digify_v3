<?php
namespace App\Models;

use App\Core\Model;

class Shop extends Model {

    /* =============================================================================================
        SECTION 1: SAVE METHODS
    ============================================================================================= */

    public function saveShop(
        null|int $p_shop_id,
        string $p_shop_name,
        int $p_company_id,
        string $p_company_name,
        int $p_shop_type_id,
        string $p_shop_type_name,
        int $p_last_log_by
    )    {
        $sql = 'CALL saveShop(
            :p_shop_id,
            :p_shop_name,
            :p_company_id,
            :p_company_name,
            :p_shop_type_id,
            :p_shop_type_name,
            :p_last_log_by
        )';

        $row = $this->fetch($sql, [
            'p_shop_id'         => $p_shop_id,
            'p_shop_name'       => $p_shop_name,
            'p_company_id'      => $p_company_id,
            'p_company_name'    => $p_company_name,
            'p_shop_type_id'    => $p_shop_type_id,
            'p_shop_type_name'  => $p_shop_type_name,
            'p_last_log_by'     => $p_last_log_by
        ]);

        return $row['new_shop_id'] ?? null;
    }
    
    /* =============================================================================================
        SECTION 2: INSERT METHODS
    ============================================================================================= */

    public function insertShopPaymentMethod(
        int $p_shop_id,
        string $p_shop_name,
        int $p_payment_method_id,
        string $p_payment_method_name,
        int $p_last_log_by
    )    {
        $sql = 'CALL insertShopPaymentMethod(
            :p_shop_id,
            :p_shop_name,
            :p_payment_method_id,
            :p_payment_method_name,
            :p_last_log_by
        )';

        return $this->query($sql, [
            'p_shop_id'             => $p_shop_id,
            'p_shop_name'           => $p_shop_name,
            'p_payment_method_id'   => $p_payment_method_id,
            'p_payment_method_name' => $p_payment_method_name,
            'p_last_log_by'         => $p_last_log_by
        ]);
    }

    public function insertShopFloorPlan(
        int $p_shop_id,
        string $p_shop_name,
        int $p_floor_plan_id,
        string $p_floor_plan_name,
        int $p_last_log_by
    )    {
        $sql = 'CALL insertShopFloorPlan(
            :p_shop_id,
            :p_shop_name,
            :p_floor_plan_id,
            :p_floor_plan_name,
            :p_last_log_by
        )';

        return $this->query($sql, [
            'p_shop_id'             => $p_shop_id,
            'p_shop_name'           => $p_shop_name,
            'p_floor_plan_id'       => $p_floor_plan_id,
            'p_floor_plan_name'     => $p_floor_plan_name,
            'p_last_log_by'         => $p_last_log_by
        ]);
    }

    public function insertShopUserAccount(
        int $p_shop_id,
        string $p_shop_name,
        int $p_user_account_id,
        string $p_file_as,
        int $p_last_log_by
    )    {
        $sql = 'CALL insertShopUserAccount(
            :p_shop_id,
            :p_shop_name,
            :p_user_account_id,
            :p_file_as,
            :p_last_log_by
        )';

        return $this->query($sql, [
            'p_shop_id'         => $p_shop_id,
            'p_shop_name'       => $p_shop_name,
            'p_user_account_id' => $p_user_account_id,
            'p_file_as'         => $p_file_as,
            'p_last_log_by'     => $p_last_log_by
        ]);
    }

    public function insertShopProduct(
        int $p_shop_id,
        string $p_shop_name,
        int $p_product_id,
        string $p_product_name,
        int $p_last_log_by
    )    {
        $sql = 'CALL insertShopProduct(
            :p_shop_id,
            :p_shop_name,
            :p_product_id,
            :p_product_name,
            :p_last_log_by
        )';

        return $this->query($sql, [
            'p_shop_id'         => $p_shop_id,
            'p_shop_name'       => $p_shop_name,
            'p_product_id'      => $p_product_id,
            'p_product_name'    => $p_product_name,
            'p_last_log_by'     => $p_last_log_by
        ]);
    }

    public function insertShopSession(
        int $p_shop_id,
        string $p_shop_name,
        string $p_open_remarks,
        string $p_file_as,
        int $p_last_log_by
    )    {
        $sql = 'CALL insertShopSession(
            :p_shop_id,
            :p_shop_name,
            :p_open_remarks,
            :p_file_as,
            :p_last_log_by
        )';

         $row = $this->fetch($sql, [
            'p_shop_id'         => $p_shop_id,
            'p_shop_name'       => $p_shop_name,
            'p_open_remarks'    => $p_open_remarks,
            'p_file_as'         => $p_file_as,
            'p_last_log_by'     => $p_last_log_by
        ]);

        return $row['new_shop_session_id'] ?? null;
    }

    public function insertShopSessionDenomination(
        int $p_shop_session_id,
        string $p_count_type,
        string $p_denomination_value,
        int $p_quantity,
        int $p_last_log_by
    )    {
        $sql = 'CALL insertShopSessionDenomination(
            :p_shop_session_id,
            :p_count_type,
            :p_denomination_value,
            :p_quantity,
            :p_last_log_by
        )';

        return $this->query($sql, [
            'p_shop_session_id'     => $p_shop_session_id,
            'p_count_type'          => $p_count_type,
            'p_denomination_value'  => $p_denomination_value,
            'p_quantity'            => $p_quantity,
            'p_last_log_by'         => $p_last_log_by
        ]);
    }

    public function insertShopOrder(
        int $p_shop_id,
        string $p_shop_name,
        int|null $p_floor_plan_table_id,
        int|null $p_table_number,
        string|null $p_order_for,
        int $p_last_log_by
    )    {
        $sql = 'CALL insertShopOrder(
            :p_shop_id,
            :p_shop_name,
            :p_floor_plan_table_id,
            :p_table_number,
            :p_order_for,
            :p_last_log_by
        )';

        $row = $this->fetch($sql, [
            'p_shop_id'             => $p_shop_id,
            'p_shop_name'           => $p_shop_name,
            'p_floor_plan_table_id' => $p_floor_plan_table_id,
            'p_table_number'        => $p_table_number,
            'p_order_for'           => $p_order_for,
            'p_last_log_by'         => $p_last_log_by
        ]);

        return $row['new_shop_order_id'] ?? null;
    }

    /* =============================================================================================
        SECTION 3: UPDATE METHODS
    =============================================================================================  */

    public function updateShopUnarchive(
        int $p_shop_id,
        int $p_last_log_by
    )    {
        $sql = 'CALL updateShopUnarchive(
            :p_shop_id,
            :p_last_log_by
        )';

        return $this->query($sql, [
            'p_shop_id'         => $p_shop_id,
            'p_last_log_by'     => $p_last_log_by
        ]);
    }

    public function updateShopArchive(
        int $p_shop_id,
        int $p_last_log_by
    )    {
        $sql = 'CALL updateShopArchive(
            :p_shop_id,
            :p_last_log_by
        )';

        return $this->query($sql, [
            'p_shop_id'         => $p_shop_id,
            'p_last_log_by'     => $p_last_log_by
        ]);
    }

    public function updateShopOrderTable(
        int $p_shop_order_id,
        int $p_floor_plan_table_id,
        int $p_table_number,
        int $p_last_log_by
    )    {
        $sql = 'CALL updateShopOrderTable(
            :p_shop_order_id,
            :p_floor_plan_table_id,
            :p_table_number,
            :p_last_log_by
        )';

        return $this->query($sql, [
            'p_shop_order_id'       => $p_shop_order_id,
            'p_floor_plan_table_id' => $p_floor_plan_table_id,
            'p_table_number'        => $p_table_number,
            'p_last_log_by'         => $p_last_log_by
        ]);
    }

    /* =============================================================================================
        SECTION 4: FETCH METHODS
    ============================================================================================= */

    public function fetchShop(
        null|string|int $p_shop_id
    ) {
        $sql = 'CALL fetchShop(
            :p_shop_id
        )';
        
        return $this->fetch($sql, [
            'p_shop_id' => $p_shop_id
        ]);
    }

    public function fetchShopSession(
        null|string|int $p_shop_id
    ) {
        $sql = 'CALL fetchShopSession(
            :p_shop_id
        )';
        
        return $this->fetch($sql, [
            'p_shop_id' => $p_shop_id
        ]);
    }

    public function fetchShopFloorPlanCount(
        null|string|int $p_shop_id
    ) {
        $sql = 'CALL fetchShopFloorPlanCount(
            :p_shop_id
        )';
        
        return $this->fetch($sql, [
            'p_shop_id' => $p_shop_id
        ]);
    }

    public function fetchShopFloorPlans(
        null|string|int $p_shop_id
    ) {
        $sql = 'CALL fetchShopFloorPlans(
            :p_shop_id
        )';
        
        return $this->fetchAll($sql, [
            'p_shop_id' => $p_shop_id
        ]);
    }

    public function fetchShopProductCategories(
        null|string|int $p_shop_id
    ) {
        $sql = 'CALL fetchShopProductCategories(
            :p_shop_id
        )';
        
        return $this->fetchAll($sql, [
            'p_shop_id' => $p_shop_id
        ]);
    }

    public function fetchShopProducts(
        null|string|int $p_shop_id,
        null|string|int $p_product_category_id,
    ) {
        $sql = 'CALL fetchShopProducts(
            :p_shop_id,
            :p_product_category_id
        )';
        
        return $this->fetchAll($sql, [
            'p_shop_id'             => $p_shop_id,
            'p_product_category_id' => $p_product_category_id
        ]);
    }

    public function fetchPOSStack(
        null|string|int $p_user_account_id
    ) {
        $sql = 'CALL fetchPOSStack(
            :p_user_account_id
        )';
        
        return $this->fetchAll($sql, [
            'p_user_account_id' => $p_user_account_id
        ]);
    }

    public function fetchActiveShopOrder(
        null|string|int $p_shop_id,
        null|string|int $p_floor_plan_table_id
    ) {
        $sql = 'CALL fetchActiveShopOrder(
            :p_shop_id,
            :p_floor_plan_table_id
        )';
        
        return $this->fetch($sql, [
            'p_shop_id'             => $p_shop_id,
            'p_floor_plan_table_id' => $p_floor_plan_table_id
        ]);
    }
    
    /* =============================================================================================
        SECTION 5: DELETE METHODS
    ============================================================================================= */

    public function deleteShop(
        int $p_shop_id
    ) {
        $sql = 'CALL deleteShop(
            :p_shop_id
        )';
        
        return $this->query($sql, [
            'p_shop_id' => $p_shop_id
        ]);
    }

    public function deleteShopPaymentMethod(
        int $p_shop_payment_method_id
    ) {
        $sql = 'CALL deleteShopPaymentMethod(
            :p_shop_payment_method_id
        )';
        
        return $this->query($sql, [
            'p_shop_payment_method_id' => $p_shop_payment_method_id
        ]);
    }

    public function deleteShopFloorPlan(
        int $p_shop_floor_plan_id
    ) {
        $sql = 'CALL deleteShopFloorPlan(
            :p_shop_floor_plan_id
        )';
        
        return $this->query($sql, [
            'p_shop_floor_plan_id' => $p_shop_floor_plan_id
        ]);
    }

    public function deleteShopAccess(
        int $p_shop_access_id
    ) {
        $sql = 'CALL deleteShopAccess(
            :p_shop_access_id
        )';
        
        return $this->query($sql, [
            'p_shop_access_id' => $p_shop_access_id
        ]);
    }

    public function deleteShopProduct(
        int $p_shop_product_id
    ) {
        $sql = 'CALL deleteShopProduct(
            :p_shop_product_id
        )';
        
        return $this->query($sql, [
            'p_shop_product_id' => $p_shop_product_id
        ]);
    }

    /* =============================================================================================
        SECTION 6: CHECK METHODS
    ============================================================================================= */

    public function checkShopExist(
        int $p_shop_id
    ) {
        $sql = 'CALL checkShopExist(
            :p_shop_id
        )';
        
        return $this->fetch($sql, [
            'p_shop_id' => $p_shop_id
        ]);
    }

    /* =============================================================================================
        SECTION 7: GENERATE METHODS
    ============================================================================================= */

    public function generateShopTable(
        null|string $p_filter_by_company,
        null|string $p_filter_by_shop_type,
        null|string $p_filter_by_shop_status,
        null|string $p_filter_by_register_status
    ) {
        $sql = 'CALL generateShopTable(
            :p_filter_by_company,
            :p_filter_by_shop_type,
            :p_filter_by_shop_status,
            :p_filter_by_register_status
        )';
        
        return $this->fetchAll($sql, [
            'p_filter_by_company'           => $p_filter_by_company,
            'p_filter_by_shop_type'         => $p_filter_by_shop_type,
            'p_filter_by_shop_status'       => $p_filter_by_shop_status,
            'p_filter_by_register_status'   => $p_filter_by_register_status
        ]);
    }

    public function generateShopPaymentMethodTable(
        null|string $p_shop_id
    ) {
        $sql = 'CALL generateShopPaymentMethodTable(
            :p_shop_id
        )';
        
        return $this->fetchAll($sql, [
            'p_shop_id' => $p_shop_id
        ]);
    }

    public function generateShopFloorPlanTable(
        null|string $p_shop_id
    ) {
        $sql = 'CALL generateShopFloorPlanTable(
            :p_shop_id
        )';
        
        return $this->fetchAll($sql, [
            'p_shop_id' => $p_shop_id
        ]);
    }

    public function generateShopAccessTable(
        null|string $p_shop_id
    ) {
        $sql = 'CALL generateShopAccessTable(
            :p_shop_id
        )';
        
        return $this->fetchAll($sql, [
            'p_shop_id' => $p_shop_id
        ]);
    }

    public function generateShopProductTable(
        null|string $p_shop_id
    ) {
        $sql = 'CALL generateShopProductTable(
            :p_shop_id
        )';
        
        return $this->fetchAll($sql, [
            'p_shop_id' => $p_shop_id
        ]);
    }

    public function generateShopOptions(
        null|int $p_shop_id
    ) {
        $sql = 'CALL generateShopOptions(
            :p_shop_id
        )';
        
        return $this->fetchAll($sql, [
            'p_shop_id' => $p_shop_id
        ]);
    }

    /* =============================================================================================
        END OF METHODS
    ============================================================================================= */
    
}