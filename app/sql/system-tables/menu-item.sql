/* ====================================================================================================
   TABLE: menu_item
   ----------------------------------------------------------------------------------------------------
   Purpose:
     Defines the individual navigation items (menus and submenus) associated with application modules,
     supporting structured navigation and hierarchical menu organization.

   Key Columns:
     - menu_item_id     : Primary key, unique identifier for each menu item
     - menu_item_name   : Name of the menu item (e.g., "User Management")
     - menu_item_url    : URL or route associated with the menu item
     - menu_item_icon   : Icon identifier/class for UI rendering
     - app_module_id    : Foreign key linking the menu item to its parent module
     - app_module_name  : Human-readable name of the associated module
     - parent_id        : Foreign key to another menu_item (for submenu hierarchy)
     - parent_name      : Human-readable name of the parent menu item
     - order_sequence   : Display order for menu rendering
     - last_log_by      : User who last updated the record (FK → user_account.user_account_id)
     - created_date     : Timestamp when the record was created
     - last_updated     : Timestamp when the record was last updated (auto-updated)

   Notes:
     - Enforces relational integrity with `app_module` and `user_account`.
     - Self-referencing structure (`parent_id`) enables nested menus/submenus.
     - Order sequencing ensures consistent display in navigation.
     - Provides auditing capability via `created_date`, `last_updated`, and `last_log_by`.
==================================================================================================== */

DROP TABLE IF EXISTS menu_item;

CREATE TABLE menu_item (
    menu_item_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
    menu_item_name VARCHAR(100) NOT NULL,
    menu_item_url VARCHAR(50),
    menu_item_icon VARCHAR(50),
    app_module_id INT UNSIGNED NOT NULL,
    app_module_name VARCHAR(100) NOT NULL,
    parent_id INT UNSIGNED,
    parent_name VARCHAR(100),
    order_sequence TINYINT(10) NOT NULL,
    created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    last_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    last_log_by INT UNSIGNED DEFAULT 1,
    FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id)
);

-- Indexes for frequent queries
CREATE INDEX idx_menu_item_app_module_id ON menu_item(app_module_id);
CREATE INDEX idx_menu_item_parent_id ON menu_item(parent_id);

INSERT INTO menu_item (menu_item_name, menu_item_url, menu_item_icon, app_module_id, app_module_name, parent_id, parent_name, order_sequence, last_log_by) VALUES
('App Module', 'app-module.php', '', 1, 'Settings', 0, '', 1, 1);
