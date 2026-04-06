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

    public function insertShopDiscounts(
        int $p_shop_id,
        string $p_shop_name,
        int $p_discount_type_id,
        string $p_discount_type_name,
        int $p_last_log_by
    )    {
        $sql = 'CALL insertShopDiscounts(
            :p_shop_id,
            :p_shop_name,
            :p_discount_type_id,
            :p_discount_type_name,
            :p_last_log_by
        )';

        return $this->query($sql, [
            'p_shop_id'             => $p_shop_id,
            'p_shop_name'           => $p_shop_name,
            'p_discount_type_id'    => $p_discount_type_id,
            'p_discount_type_name'  => $p_discount_type_name,
            'p_last_log_by'         => $p_last_log_by
        ]);
    }

    public function insertShopCharges(
        int $p_shop_id,
        string $p_shop_name,
        int $p_charge_type_id,
        string $p_charge_type_name,
        int $p_last_log_by
    )    {
        $sql = 'CALL insertShopCharges(
            :p_shop_id,
            :p_shop_name,
            :p_charge_type_id,
            :p_charge_type_name,
            :p_last_log_by
        )';

        return $this->query($sql, [
            'p_shop_id'             => $p_shop_id,
            'p_shop_name'           => $p_shop_name,
            'p_charge_type_id'      => $p_charge_type_id,
            'p_charge_type_name'    => $p_charge_type_name,
            'p_last_log_by'         => $p_last_log_by
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

    public function insertShopOrderDetail(
        int $p_shop_order_id,
        int $p_product_id,
        string $p_product_name,
        string $p_quantity,
        string $p_base_price,
        string $p_inclusive_rate,
        string $p_additive_rate,
        string $p_subtotal,
        string $p_inclusive_tax_amount,
        string $p_additive_tax_amount,
        string $p_net_sales,
        int $p_last_log_by
    )    {
        $sql = 'CALL insertShopOrderDetail(
            :p_shop_order_id,
            :p_product_id,
            :p_product_name,
            :p_quantity,
            :p_base_price,
            :p_inclusive_rate,
            :p_additive_rate,
            :p_subtotal,
            :p_inclusive_tax_amount,
            :p_additive_tax_amount,
            :p_net_sales,
            :p_last_log_by
        )';

        return $this->query($sql, [
            'p_shop_order_id'           => $p_shop_order_id,
            'p_product_id'              => $p_product_id,
            'p_product_name'            => $p_product_name,
            'p_quantity'                => $p_quantity,
            'p_base_price'              => $p_base_price,
            'p_inclusive_rate'          => $p_inclusive_rate,
            'p_additive_rate'           => $p_additive_rate,
            'p_subtotal'                => $p_subtotal,
            'p_inclusive_tax_amount'    => $p_inclusive_tax_amount,
            'p_additive_tax_amount'     => $p_additive_tax_amount,
            'p_net_sales'               => $p_net_sales,
            'p_last_log_by'             => $p_last_log_by
        ]);
    }

    public function insertShopOrderAppliedDiscounts(
        int $p_shop_order_id,
        int $p_discount_type_id,
        string $p_discount_name,
        string $p_applied_value,
        string $p_calculated_amount,
        string $p_value_type,
        string $p_application_order,
        string $p_is_vat_exempt,
        string $p_remarks,
        int $p_last_log_by
    )    {
        $sql = 'CALL insertShopOrderAppliedDiscounts(
            :p_shop_order_id,
            :p_discount_type_id,
            :p_discount_name,
            :p_applied_value,
            :p_calculated_amount,
            :p_value_type,
            :p_application_order,
            :p_is_vat_exempt,
            :p_remarks,
            :p_last_log_by
        )';

        return $this->query($sql, [
            'p_shop_order_id'       => $p_shop_order_id,
            'p_discount_type_id'    => $p_discount_type_id,
            'p_discount_name'       => $p_discount_name,
            'p_applied_value'       => $p_applied_value,
            'p_calculated_amount'   => $p_calculated_amount,
            'p_value_type'          => $p_value_type,
            'p_application_order'   => $p_application_order,
            'p_is_vat_exempt'       => $p_is_vat_exempt,
            'p_remarks'             => $p_remarks,
            'p_last_log_by'         => $p_last_log_by
        ]);
    }

    public function insertShopOrderAppliedCharges(
        int $p_shop_order_id,
        int $p_charge_type_id,
        string $p_charge_name,
        string $p_applied_value,
        string $p_calculated_amount,
        string $p_value_type,
        string $p_application_order,
        string $p_tax_type,
        string $p_remarks,
        int $p_last_log_by
    )    {
        $sql = 'CALL insertShopOrderAppliedCharges(
            :p_shop_order_id,
            :p_charge_type_id,
            :p_charge_name,
            :p_applied_value,
            :p_calculated_amount,
            :p_value_type,
            :p_application_order,
            :p_tax_type,
            :p_remarks,
            :p_last_log_by
        )';

        return $this->query($sql, [
            'p_shop_order_id'       => $p_shop_order_id,
            'p_charge_type_id'      => $p_charge_type_id,
            'p_charge_name'         => $p_charge_name,
            'p_applied_value'       => $p_applied_value,
            'p_calculated_amount'   => $p_calculated_amount,
            'p_value_type'          => $p_value_type,
            'p_application_order'   => $p_application_order,
            'p_tax_type'            => $p_tax_type,
            'p_remarks'             => $p_remarks,
            'p_last_log_by'         => $p_last_log_by
        ]);
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

    public function updateShopOrderTab(
        int $p_shop_order_id,
        string $p_order_for,
        int $p_last_log_by
    )    {
        $sql = 'CALL updateShopOrderTab(
            :p_shop_order_id,
            :p_order_for,
            :p_last_log_by
        )';

        return $this->query($sql, [
            'p_shop_order_id'   => $p_shop_order_id,
            'p_order_for'       => $p_order_for,
            'p_last_log_by'     => $p_last_log_by
        ]);
    }

    public function updateShopOrderToCancel(
        int $p_shop_order_id,
        null|string $p_cancelled_reason,
        int $p_last_log_by
    )    {
        $sql = 'CALL updateShopOrderToCancel(
            :p_shop_order_id,
            :p_cancelled_reason,
            :p_last_log_by
        )';

        return $this->query($sql, [
            'p_shop_order_id'       => $p_shop_order_id,
            'p_cancelled_reason'    => $p_cancelled_reason,
            'p_last_log_by'         => $p_last_log_by
        ]);
    }

    public function updateShopOrderPreset(
        int $p_shop_order_id,
        string $p_order_preset,
        int $p_last_log_by
    )    {
        $sql = 'CALL updateShopOrderPreset(
            :p_shop_order_id,
            :p_order_preset,
            :p_last_log_by
        )';

        return $this->query($sql, [
            'p_shop_order_id'   => $p_shop_order_id,
            'p_order_preset'    => $p_order_preset,
            'p_last_log_by'     => $p_last_log_by
        ]);
    }

    public function updateShopOrderDetails(
        int $p_shop_order_details_id,
        string $p_quantity,
        string $p_discount_type,
        string $p_discount_value,
        string $p_discount_amount,
        string $p_base_price,
        string $p_discount_per_unit,
        string $p_net_price_per_unit,
        string $p_inclusive_rate,
        string $p_additive_rate,
        string $p_inclusive_tax_per_unit,
        string $p_additive_tax_per_unit,
        string $p_note,
        int $p_last_log_by
    )    {
        $sql = 'CALL updateShopOrderDetails(
            :p_shop_order_details_id,
            :p_quantity,
            :p_discount_type,
            :p_discount_value,
            :p_discount_amount,
            :p_base_price,
            :p_discount_per_unit,
            :p_net_price_per_unit,
            :p_inclusive_rate,
            :p_additive_rate,
            :p_inclusive_tax_per_unit,
            :p_additive_tax_per_unit,
            :p_note,
            :p_last_log_by
        )';

        return $this->query($sql, [
            'p_shop_order_details_id'   => $p_shop_order_details_id,
            'p_quantity'                => $p_quantity,
            'p_discount_type'           => $p_discount_type,
            'p_discount_value'          => $p_discount_value,
            'p_discount_amount'         => $p_discount_amount,
            'p_base_price'              => $p_base_price,
            'p_discount_per_unit'       => $p_discount_per_unit,
            'p_net_price_per_unit'      => $p_net_price_per_unit,
            'p_inclusive_rate'          => $p_inclusive_rate,
            'p_additive_rate'           => $p_additive_rate,
            'p_inclusive_tax_per_unit'  => $p_inclusive_tax_per_unit,
            'p_additive_tax_per_unit'   => $p_additive_tax_per_unit,
            'p_note'                    => $p_note,
            'p_last_log_by'             => $p_last_log_by
        ]);
    }

    public function updateShopOrderQuantity(
        int $p_shop_order_details_id,
        string $p_quantity,
        int $p_last_log_by
    )    {
        $sql = 'CALL updateShopOrderQuantity(
            :p_shop_order_details_id,
            :p_quantity,
            :p_last_log_by
        )';

        return $this->query($sql, [
            'p_shop_order_details_id'   => $p_shop_order_details_id,
            'p_quantity'                => $p_quantity,
            'p_last_log_by'             => $p_last_log_by
        ]);
    }

    public function updateShopOrderNote(
        int $p_shop_order_details_id,
        string $p_note,
        int $p_last_log_by
    )    {
        $sql = 'CALL updateShopOrderNote(
            :p_shop_order_details_id,
            :p_note,
            :p_last_log_by
        )';

        return $this->query($sql, [
            'p_shop_order_details_id'   => $p_shop_order_details_id,
            'p_note'                    => $p_note,
            'p_last_log_by'             => $p_last_log_by
        ]);
    }

    public function updateShopOrderDetail(
        int $p_shop_order_id,
        int $p_product_id,
        string $p_quantity,
        string $p_base_price,
        string $p_inclusive_rate,
        string $p_additive_rate,
        string $p_subtotal,
        string $p_inclusive_tax_amount,
        string $p_additive_tax_amount,
        string $p_net_sales,
        int $p_last_log_by
    )    {
        $sql = 'CALL updateShopOrderDetail(
            :p_shop_order_id,
            :p_product_id,
            :p_quantity,
            :p_base_price,
            :p_inclusive_rate,
            :p_additive_rate,
            :p_subtotal,
            :p_inclusive_tax_amount,
            :p_additive_tax_amount,
            :p_net_sales,
            :p_last_log_by
        )';

        return $this->query($sql, [
            'p_shop_order_id'           => $p_shop_order_id,
            'p_product_id'              => $p_product_id,
            'p_quantity'                => $p_quantity,
            'p_base_price'              => $p_base_price,
            'p_inclusive_rate'          => $p_inclusive_rate,
            'p_additive_rate'           => $p_additive_rate,
            'p_subtotal'                => $p_subtotal,
            'p_inclusive_tax_amount'    => $p_inclusive_tax_amount,
            'p_additive_tax_amount'     => $p_additive_tax_amount,
            'p_net_sales'               => $p_net_sales,
            'p_last_log_by'             => $p_last_log_by
        ]);
    }

    public function updateShopOrderTotal(
        int $p_shop_order_id,
        int $p_last_log_by
    )    {
        $sql = 'CALL updateShopOrderTotal(
            :p_shop_order_id,
            :p_last_log_by
        )';

        return $this->query($sql, [
            'p_shop_order_id'   => $p_shop_order_id,
            'p_last_log_by'     => $p_last_log_by
        ]);
    }

    public function updateShopDiscountApplication(
        int $p_shop_discounts_id,
        string $p_automatic_application,
        int $p_last_log_by
    )    {
        $sql = 'CALL updateShopDiscountApplication(
            :p_shop_discounts_id,
            :p_automatic_application,
            :p_last_log_by
        )';

        return $this->query($sql, [
            'p_shop_discounts_id'   => $p_shop_discounts_id,
            'p_automatic_application'   => $p_automatic_application,
            'p_last_log_by'         => $p_last_log_by
        ]);
    }

    public function updateShopChargeApplication(
        int $p_shop_charges_id,
        string $p_automatic_application,
        int $p_last_log_by
    )    {
        $sql = 'CALL updateShopChargeApplication(
            :p_shop_charges_id,
            :p_automatic_application,
            :p_last_log_by
        )';

        return $this->query($sql, [
            'p_shop_charges_id'   => $p_shop_charges_id,
            'p_automatic_application'   => $p_automatic_application,
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

    public function fetchShopOrderList(
        null|string|int $p_shop_order_id
    ) {
        $sql = 'CALL fetchShopOrderList(
            :p_shop_order_id
        )';
        
        return $this->fetchAll($sql, [
            'p_shop_order_id' => $p_shop_order_id
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

    public function fetchShopOrderTotal(
        null|string|int $p_shop_order_id,
    ) {
        $sql = 'CALL fetchShopOrderTotal(
            :p_shop_order_id
        )';
        
        return $this->fetch($sql, [
            'p_shop_order_id' => $p_shop_order_id
        ]);
    }

    public function fetchAppliedDiscount(
        null|string|int $p_shop_order_id,
        null|string|int $p_discount_type_id,
    ) {
        $sql = 'CALL fetchAppliedDiscount(
            :p_shop_order_id,
            :p_discount_type_id
        )';
        
        return $this->fetch($sql, [
            'p_shop_order_id'       => $p_shop_order_id,
            'p_discount_type_id'    => $p_discount_type_id
        ]);
    }

    public function fetchAppliedCharge(
        null|string|int $p_shop_order_id,
        null|string|int $p_charge_type_id,
    ) {
        $sql = 'CALL fetchAppliedCharge(
            :p_shop_order_id,
            :p_charge_type_id
        )';
        
        return $this->fetch($sql, [
            'p_shop_order_id'   => $p_shop_order_id,
            'p_charge_type_id'  => $p_charge_type_id
        ]);
    }

    public function fetchShopOrderDetails(
        null|string|int $p_shop_order_id,
    ) {
        $sql = 'CALL fetchShopOrderDetails(
            :p_shop_order_id
        )';
        
        return $this->fetch($sql, [
            'p_shop_order_id' => $p_shop_order_id
        ]);
    }

    public function fetchShopOrderDetailDetails(
        null|string|int $p_shop_order_details_id,
    ) {
        $sql = 'CALL fetchShopOrderDetailDetails(
            :p_shop_order_details_id
        )';
        
        return $this->fetch($sql, [
            'p_shop_order_details_id' => $p_shop_order_details_id
        ]);
    }

    public function fetchShopOrderDetailsByProduct(
        null|string|int $p_shop_order_id,
        null|string|int $p_product_id
    ) {
        $sql = 'CALL fetchShopOrderDetailsByProduct(
            :p_shop_order_id,
            :p_product_id
        )';
        
        return $this->fetch($sql, [
            'p_shop_order_id'   => $p_shop_order_id,
            'p_product_id'      => $p_product_id
        ]);
    }

    public function fetchShopDiscounts(
        null|string|int $p_shop_id
    ) {
        $sql = 'CALL fetchShopDiscounts(
            :p_shop_id
        )';
        
        return $this->fetchAll($sql, [
            'p_shop_id' => $p_shop_id
        ]);
    }

    public function fetchOrderCharges(
        null|string|int $p_shop_order_id
    ) {
        $sql = 'CALL fetchOrderCharges(
            :p_shop_order_id
        )';
        
        return $this->fetchAll($sql, [
            'p_shop_order_id' => $p_shop_order_id
        ]);
    }

    public function fetchOrderDiscounts(
        null|string|int $p_shop_order_id
    ) {
        $sql = 'CALL fetchOrderDiscounts(
            :p_shop_order_id
        )';
        
        return $this->fetchAll($sql, [
            'p_shop_order_id' => $p_shop_order_id
        ]);
    }

    public function fetchShopCharges(
        null|string|int $p_shop_order_id
    ) {
        $sql = 'CALL fetchShopCharges(
            :p_shop_order_id
        )';
        
        return $this->fetchAll($sql, [
            'p_shop_order_id' => $p_shop_order_id
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

    public function deleteShopDiscounts(
        int $p_shop_discounts_id
    ) {
        $sql = 'CALL deleteShopDiscounts(
            :p_shop_discounts_id
        )';
        
        return $this->query($sql, [
            'p_shop_discounts_id' => $p_shop_discounts_id
        ]);
    }

    public function deleteShopCharges(
        int $p_shop_charges_id
    ) {
        $sql = 'CALL deleteShopCharges(
            :p_shop_charges_id
        )';
        
        return $this->query($sql, [
            'p_shop_charges_id' => $p_shop_charges_id
        ]);
    }

    public function deleteShopOrderDetails(
        int $p_shop_order_details_id
    ) {
        $sql = 'CALL deleteShopOrderDetails(
            :p_shop_order_details_id
        )';
        
        return $this->query($sql, [
            'p_shop_order_details_id' => $p_shop_order_details_id
        ]);
    }

    public function deleteShopOrderAppliedDiscounts(
        int $p_shop_order_id,
        int $p_discount_type_id
    ) {
        $sql = 'CALL deleteShopOrderAppliedDiscounts(
            :p_shop_order_id,
            :p_discount_type_id
        )';
        
        return $this->query($sql, [
            'p_shop_order_id'       => $p_shop_order_id,
            'p_discount_type_id'    => $p_discount_type_id
        ]);
    }

    public function deleteShopOrderAppliedCharges(
        int $p_shop_order_id,
        int $p_charge_type_id
    ) {
        $sql = 'CALL deleteShopOrderAppliedCharges(
            :p_shop_order_id,
            :p_charge_type_id
        )';
        
        return $this->query($sql, [
            'p_shop_order_id'   => $p_shop_order_id,
            'p_charge_type_id'  => $p_charge_type_id
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

    public function checkShopOrderProductExist(
        int $p_shop_id,
        int $p_product_id
    ) {
        $sql = 'CALL checkShopOrderProductExist(
            :p_shop_id,
            :p_product_id
        )';
        
        return $this->fetch($sql, [
            'p_shop_id'     => $p_shop_id,
            'p_product_id'  => $p_product_id
        ]);
    }

    public function checkExistingVatExemptDiscount(
        int $p_shop_order_id
    ) {
        $sql = 'CALL checkExistingVatExemptDiscount(
            :p_shop_order_id
        )';
        
        return $this->fetch($sql, [
            'p_shop_order_id' => $p_shop_order_id
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

    public function generateShopDiscountsTable(
        null|string $p_shop_id
    ) {
        $sql = 'CALL generateShopDiscountsTable(
            :p_shop_id
        )';
        
        return $this->fetchAll($sql, [
            'p_shop_id' => $p_shop_id
        ]);
    }

    public function generateShopChargesTable(
        null|string $p_shop_id
    ) {
        $sql = 'CALL generateShopChargesTable(
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
        SECTION 8: CUSTOM METHODS
    ============================================================================================= */

    public function processKitchenTicket(
        int $shopOrderId,
        int $lastLogBy
    ) {
        $sql = 'CALL processKitchenTicket(
            :p_shop_order_id,
            :p_last_log_by
        )';

        return $this->fetch($sql, [
            'p_shop_order_id' => $shopOrderId,
            'p_last_log_by'   => $lastLogBy
        ]);
    }

    public function getShopPaymentMethods(int $shopId, int $orderId) {
        // Get total due from order
        $order = $this->fetch("SELECT total_amount_due FROM shop_order WHERE shop_order_id = ?", [$orderId]);
        
        // Get methods assigned to this shop
        $methods = $this->fetchAll("SELECT payment_method_id, payment_method_name 
                                    FROM shop_payment_method WHERE shop_id = ?", [$shopId]);
        
        return ['total_due' => $order['total_amount_due'], 'methods' => $methods];
    }

    public function savePayment($orderId, $methodId, $amount, $ref, $userId) {
        return $this->fetch("CALL processOrderPayment(?, ?, ?, ?, ?)", [$orderId, $methodId, $amount, $ref, $userId]);
    }

    /* =============================================================================================
        END OF METHODS
    ============================================================================================= */
    
}