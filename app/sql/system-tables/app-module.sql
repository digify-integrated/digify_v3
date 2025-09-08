/* ====================================================================================================
   TABLE: app_module
   ----------------------------------------------------------------------------------------------------
   Purpose:
     Defines application modules that are tied to menu items, allowing structured navigation and 
     centralized control of system modules.

   Key Columns:
     - app_module_id          : Primary key, unique identifier for each application module
     - app_module_name        : Name of the module (e.g., "Settings")
     - app_module_description : Description of the module’s purpose or functionality
     - app_logo               : Path to module logo (stored in ./storage/uploads/app_module/)
     - menu_item_id           : Foreign key linking the module to a menu item
     - menu_item_name         : Human-readable name of the menu item
     - order_sequence         : Sequence order for module display in menus
     - last_log_by            : User who last updated the record (FK → user_account.user_account_id)
     - created_date           : Timestamp when the record was created
     - last_updated           : Timestamp when the record was last updated (auto-updated)

   Notes:
     - Enforces relational integrity with `menu_item` and `user_account` tables via foreign keys.
     - Includes an index on `menu_item_id` to optimize lookups for modules under specific menus.
     - Provides auditing capability via `created_date`, `last_updated`, and `last_log_by`.
==================================================================================================== */

DROP TABLE IF EXISTS app_module;

CREATE TABLE app_module (
    app_module_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
    app_module_name VARCHAR(100) NOT NULL,
    app_module_description VARCHAR(500) NOT NULL,
    app_logo VARCHAR(500),
    menu_item_id INT UNSIGNED NOT NULL,
    menu_item_name VARCHAR(100) NOT NULL,
    order_sequence TINYINT(10) NOT NULL,
    created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    last_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    last_log_by INT UNSIGNED DEFAULT 1,
    FOREIGN KEY (last_log_by) REFERENCES user_account(user_account_id)
);

-- Indexes for frequent queries
CREATE INDEX idx_app_module_menu_item_id ON app_module(menu_item_id);

INSERT INTO app_module (app_module_id, app_module_name, app_module_description, app_logo, menu_item_id, menu_item_name, order_sequence, last_log_by) VALUES
(1, 'Settings', 'Centralized management hub for comprehensive organizational oversight and control', './storage/uploads/app_module/1/Pboex.png', 1, 'App Module', 100, 1);

