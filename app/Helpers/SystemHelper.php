<?php

namespace App\Helpers;

use App\Core\Security;
use DateTime;

/**
 * Class SystemHelper
 *
 * Collection of utility methods for date formatting, file handling,
 * network utilities, and system response helpers.
 *
 * @package App\Helpers
 */
class SystemHelper extends Security {
    /**
     * Returns a human-readable elapsed time string.
     *
     * @param string $dateTime Date/time string
     * @return string Human-readable string
     */
    public static function timeElapsedString(string $dateTime) {
        $timestamp = strtotime($dateTime);
        if ($timestamp === false) {
            return 'Invalid date';
        }

        $diffSeconds = time() - $timestamp;

        // If older than 24 hours, return full date
        if ($diffSeconds > 86400) {
            return date('M j, Y \a\t h:i:s A', $timestamp);
        }

        if ($diffSeconds < 60) {
            return 'Just Now';
        }

        $intervals = [
            31536000    => 'year',
            2592000     => 'month',
            604800      => 'week',
            86400       => 'day',
            3600        => 'hour',
            60          => 'minute',
            1           => 'second',
        ];

        foreach ($intervals as $seconds => $label) {
            $count = floor($diffSeconds / $seconds);
            if ($count > 0) {
                return sprintf(
                    '%d %s ago',
                    $count,
                    $label . ($count > 1 ? 's' : '')
                );
            }
        }

        return date('M j, Y \a\t h:i:s A', $timestamp);
    }

    /**
     * Compare two month/year strings and return elapsed difference.
     *
     * @param string $startDateTime Format: "Month Year" (e.g. "January 2023")
     * @param string $endDateTime   Format: "Month Year"
     * @return string Elapsed difference or error
     */
    public static function yearMonthElapsedComparisonString(string $startDateTime, string $endDateTime) {
        $startDate  = DateTime::createFromFormat('d F Y', '01 ' . $startDateTime);
        $endDate    = DateTime::createFromFormat('d F Y', '01 ' . $endDateTime);

        if ($startDate && $endDate) {
            $interval = $startDate->diff($endDate);

            $parts = [];
            if ($interval->y > 0) {
                $parts[] = $interval->y . ' ' . ($interval->y === 1 ? 'year' : 'years');
            }
            if ($interval->m > 0) {
                $parts[] = $interval->m . ' ' . ($interval->m === 1 ? 'month' : 'months');
            }

            return $parts ? implode(' and ', $parts) : 'Just Now';
        }

        return 'Error parsing dates';
    }

    /**
     * Format a given date with optional modification.
     *
     * @param string      $format Date format string
     * @param string      $date   Input date
     * @param string|null $modify Modification string (e.g. "+1 day")
     * @return string Formatted date
     */
    public static function formatDate(string $format, string $date, ?string $modify = null) {
        $dateTime = new DateTime($date);
        if ($modify) {
            $dateTime->modify($modify);
        }
        return $dateTime->format($format);
    }

    /**
     * Convert duration (seconds) into human-readable parts.
     *
     * @param int $lockDuration Duration in seconds
     * @return array Duration parts
     */
    public static function formatDuration(int $lockDuration) {
        $parts = [];

        $units = [
            ['year',   31536000],
            ['month',  2592000],
            ['day',    86400],
            ['hour',   3600],
            ['minute', 60],
            ['second', 1],
        ];

        foreach ($units as [$unit, $seconds]) {
            $value = intdiv($lockDuration, $seconds);
            $lockDuration %= $seconds;

            if ($value > 0) {
                $parts[] = number_format($value) . ' ' . $unit . ($value > 1 ? 's' : '');
            }
        }

        return $parts ?: ['less than a second'];
    }
    
    /**
     * Get default system image by type.
     *
     * @param string $type
     * @return string Image path
     */
    public static function fetchDefaultImage(string $type) {
        $defaults = [
            'profile'               => DEFAULT_AVATAR_IMAGE,
            'login background'      => DEFAULT_BG_IMAGE,
            'login logo'            => DEFAULT_LOGIN_LOGO_IMAGE,
            'menu logo'             => DEFAULT_MENU_LOGO_IMAGE,
            'module icon'           => DEFAULT_MODULE_ICON_IMAGE,
            'favicon'               => DEFAULT_FAVICON_IMAGE,
            'company logo'          => DEFAULT_COMPANY_LOGO,
            'id placeholder front'  => DEFAULT_ID_PLACEHOLDER_FRONT,
            'app module logo'       => DEFAULT_APP_MODULE_LOGO,
            'upload placeholder'    => DEFAULT_UPLOAD_PLACEHOLDER,
            'null'                  => null
        ];

        return $defaults[$type] ?? DEFAULT_PLACEHOLDER_IMAGE;
    }

    /**
     * Ensure image path exists, else return default.
     *
     * @param string|null $image
     * @param string      $type
     * @return string Image path
     */
    public static function checkImageExist(?string $image, string $type) {
        if (empty($image)) {
            return self::fetchDefaultImage($type);
        }

        // Normalize path (remove leading "./" if present)
        $normalizedPath = ltrim($image, './');

        // Build filesystem path relative to project root
        $filePath = __DIR__ . '/../../' . $normalizedPath;

        if (file_exists($filePath)) {
            // Return the web-accessible path (not filesystem path)
            return $normalizedPath;
        }

        return self::fetchDefaultImage($type);
    }

    /**
     * Delete image if it exists.
     *
     * @param string|null $image
     * @return bool True if deleted, false if not
     */
    public static function deleteFileIfExist(?string $file) {
        if (!defined('PROJECT_BASE_DIR')) {
            define('PROJECT_BASE_DIR', dirname(__DIR__, 2));
        }

        if (empty($file)) {
            return true;
        }

        $normalizedPath     = ltrim($file, './');
        $filePath           = PROJECT_BASE_DIR . '/' . $normalizedPath;

        if (file_exists($filePath)) {
            return unlink($filePath);
        }

        return true;
    }

    public static function fetchFileDetails(?string $filePath, bool $withIcon = false) {
        if (empty($filePath)) {
            return null;
        }

        // Normalize path (remove leading "./" if present)
        $normalizedPath = ltrim($filePath, './');

        // Build absolute path relative to project root
        $absolutePath = __DIR__ . '/../../' . $normalizedPath;

        // Check if the file actually exists
        if (!file_exists($absolutePath)) {
            return null; // Or return ['size' => null, 'icon' => null] depending on how you want to handle missing files
        }

        // Get file size in bytes and format it
        $fileSizeBytes  = filesize($absolutePath);
        $formattedSize  = self::fetchFormatBytes($fileSizeBytes);

        // Prepare the response
        $result = [
            'size' => $formattedSize,
        ];

        // Optionally get the icon based on extension
        if ($withIcon) {
            $extension          = strtolower(pathinfo($normalizedPath, PATHINFO_EXTENSION));
            $icon               = self::getFileExtensionIcon($extension);
            $result['icon']     = $icon;
        }

        return $result;
    }



    /**
     * Map file extension to icon.
     *
     * @param string $type File extension
     * @return string Icon path
     */
    public static function getFileExtensionIcon(string $type) {
        $icons = [
            'ai'    => './assets/images/file_icon/img-file-ai.svg',
            'doc'   => './assets/images/file_icon/img-file-doc.svg',
            'docx'  => './assets/images/file_icon/img-file-doc.svg',
            'jpeg'  => './assets/images/file_icon/img-file-img.svg',
            'jpg'   => './assets/images/file_icon/img-file-img.svg',
            'png'   => './assets/images/file_icon/img-file-img.svg',
            'gif'   => './assets/images/file_icon/img-file-img.svg',
            'pdf'   => './assets/images/file_icon/img-file-pdf.svg',
            'ppt'   => './assets/images/file_icon/img-file-ppt.svg',
            'pptx'  => './assets/images/file_icon/img-file-ppt.svg',
            'rar'   => './assets/images/file_icon/img-file-rar.svg',
            'txt'   => './assets/images/file_icon/img-file-txt.svg',
            'xls'   => './assets/images/file_icon/img-file-xls.svg',
            'xlsx'  => './assets/images/file_icon/img-file-xls.svg',
        ];

        return $icons[$type] ?? './assets/images/file_icon/img-file-img.svg';
    }

    /**
     * Format bytes into human-readable size.
     *
     * @param int $bytes
     * @param int $precision
     * @return string
     */
    public static function fetchFormatBytes(int $bytes, int $precision = 2) {
        $units  = ['B', 'Kb', 'Mb', 'Gb', 'Tb', 'Pb', 'Eb', 'Zb', 'Yb'];
        $bytes  = max($bytes, 0);
        $pow    = (int) floor(log($bytes ?: 1, 1024));

        return round($bytes / (1 << (10 * $pow)), $precision) . ' ' . $units[$pow];
    }

    /**
     * Generate HTML month <option> elements.
     *
     * @return string
     */
    public static function generateMonthOptions() {
        $months = [
            'January','February','March','April',
            'May','June','July','August',
            'September','October','November','December'
        ];

        return implode('', array_map(
            fn($m) => "<option value=\"$m\">$m</option>",
            $months
        ));
    }

    /**
     * Generate HTML year <option> elements.
     *
     * @param int $start Start year
     * @param int $end   End year
     * @return string
     */
    public static function generateYearOptions(int $start, int $end) {
        return implode('', array_map(
            fn($y) => "<option value=\"$y\">$y</option>",
            range($start, $end)
        ));
    }
    
    /**
     * Send standardized JSON error response and exit.
     */
    public static function sendErrorResponse(string $title, string $message, array $additionalData = []) {
        $response = array_merge([
            'success'       => false,
            'title'         => $title,
            'message'       => $message,
            'message_type'  => 'error',
        ], $additionalData);

        echo json_encode($response);
        exit;
    }

    /**
     * Send standardized JSON success response and exit.
     */
    public static function sendSuccessResponse(string $title, string $message, array $additionalData = []) {
        $response = array_merge([
            'success'       => true,
            'title'         => $title,
            'message'       => $message,
            'message_type'  => 'success',
        ], $additionalData);

        echo json_encode($response);
        exit;
    }
    /**
     * Redirects the user.
     */
    public static function redirect(string $url): void
    {
        header("Location: $url");
        exit;
    }

    public function buildMenuItemHTML($menuItemDetails, $level = 1) {
        $html = '';
        $menuItemID     = Security::encryptData($menuItemDetails['MENU_ITEM_ID'] ?? null);
        $appModuleID    = Security::encryptData($menuItemDetails['APP_MODULE_ID'] ?? null);
        $menuItemName   = $menuItemDetails['MENU_ITEM_NAME'] ?? null;
        $menuItemIcon   = $menuItemDetails['MENU_ITEM_ICON'] ?? null;
        $menuItemURL    = $menuItemDetails['MENU_ITEM_URL'] ?? null;
        $children       = $menuItemDetails['CHILDREN'] ?? null;
    
        $menuItemURL = !empty($menuItemURL) ? (strpos($menuItemURL, '?page_id=') !== false ? $menuItemURL : $menuItemURL . '?app_module_id=' . $appModuleID . '&page_id=' . $menuItemID) : 'javascript:void(0)';
    
        if ($level === 1) {
            if (empty($children)) {
                $html .= ' <div data-kt-menu-trigger="{default: \'click\', lg: \'hover\'}" data-kt-menu-placement="bottom-start" class="menu-item menu-here-bg menu-lg-down-accordion me-0 me-lg-2">
                            <a class="menu-link" href="'. $menuItemURL .'">            
                                <span class="menu-title">'. $menuItemName .'</span>
                            </a>
                        </div>';
            }
            else {
                $html .= '<div data-kt-menu-trigger="{default: \'click\', lg: \'hover\'}" data-kt-menu-placement="bottom-start" class="menu-item menu-lg-down-accordion menu-sub-lg-down-indention me-0 me-lg-2">
                                <span class="menu-link">
                                    <span class="menu-title">'. $menuItemName .'</span>
                                    <span class="menu-arrow d-lg-none"></span>
                                </span>
                                <div class="menu-sub menu-sub-lg-down-accordion menu-sub-lg-dropdown px-lg-2 py-lg-4 w-lg-250px">';

                foreach ($children as $child) {
                    $html .= $this->buildMenuItemHTML($child, $level + 1);
                }
    
                $html .= '</div>
                        </div>';
            }
        }
        else {
            if($level == 2){
                $icon = '<span class="menu-icon">
                                    <i class="'. $menuItemIcon .' fs-2"></i>
                                </span>';
            }
            else{
                $icon = '<span class="menu-bullet">
                                    <span class="bullet bullet-dot"></span>
                                </span>';
            }
            
            if (empty($children)) {
                $html .= ' <div data-kt-menu-trigger="{default: \'click\', lg: \'hover\'}" data-kt-menu-placement="bottom-start" class="menu-item menu-lg-down-accordion">
                                <a class="menu-link" href="'. $menuItemURL .'">
                                    '. $icon .'
                                    <span class="menu-title">'. $menuItemName .'</span>
                                </a>
                            </div>';
            }
            else {
                $html .= '  <div data-kt-menu-trigger="{default: \'click\', lg: \'hover\'}" data-kt-menu-placement="right-start" class="menu-item menu-lg-down-accordion">
                                <span class="menu-link">
                                    '. $icon .'
                                    <span class="menu-title">'. $menuItemName .'</span>
                                    <span class="menu-arrow"></span>
                                </span>
                                <div class="menu-sub menu-sub-lg-down-accordion menu-sub-lg-dropdown menu-active-bg px-lg-2 py-lg-4 w-lg-225px">';

                foreach ($children as $child) {
                    $html .= $this->buildMenuItemHTML($child, $level + 1);
                }
    
                $html .= '</div>
                </div>';
            }
        }
    
        return $html;
    }

    public static function checkFilter($values) {
        if ($values === null) {
            return null;
        }

        // If it's a string, split by comma and trim whitespace
        if (is_string($values)) {
            // Split only if it contains a comma, otherwise wrap it as a single value
            $values = strpos($values, ',') !== false
                ? explode(',', $values)
                : [$values];
        } elseif (!is_array($values)) {
            // Wrap non-array, non-string types
            $values = [$values];
        }

        // Clean and escape values
        $cleanValues = array_filter(
            array_map('trim', $values),
            fn($v) => $v !== ''
        );

        return $cleanValues
            ? "'" . implode("','", array_map('addslashes', $cleanValues)) . "'"
            : null;
    }

    public function checkDate($type, $date, $time, $format, $modify, $systemDate = null, $systemTime = null) {
        $systemDate     ??= date('Y-m-d');
        $systemTime     ??= date('H:i:s');

        if (empty($date)) {
            return $this->fetchDefaultReturnValue($type, $systemDate, $systemTime);
        }

        $formattedDate = $this->formatDate($format, $date, $modify);

        if ($this->needsTime($type) && !empty($time)) {
            return "$formattedDate $time";
        }

        return $formattedDate;
    }

    private function needsTime(string $type) {
        static $typesRequiringTime = ['complete', 'encoded', 'date time'];
        return in_array(strtolower($type), $typesRequiringTime, true);
    }
    # -------------------------------------------------------------

    # -------------------------------------------------------------
    private static function fetchDefaultReturnValue($type, $systemDate, $systemTime) {
        $type = strtolower($type);

        return match ($type) {
            'default'                                   => $systemDate,
            'default time'                              => $systemTime,
            'summary'                                   => '--',
            'na', 'complete', 'encoded', 'date time'    => 'N/A',
            'empty', 'attendance empty'                 => null,
            default                                     => null,
        };

    }

    public static function fetchPageFiles(
        string $folder,
        array $options = [],
        array $overrides = []
    ) {
        $page = 'index';

        if (!empty($options['newRecord'])) {
            $page = 'new';
        } elseif (!empty($options['detailID'])) {
            $page = 'details';
        }

        $contentFile = "./app/Views/Page/$folder/$page.php";
        $scriptFile  = "./assets/js/page/$folder/$page.js";

        if (isset($_GET['import']) && !empty($_GET['import'])) {
            $contentFile = "./app/Views/Page/import/import.php";
            $scriptFile  = "./assets/js/page/import/import.js";
        }

        if (isset($overrides['content'])) $contentFile = $overrides['content'];
        if (isset($overrides['script']))  $scriptFile  = $overrides['script'];

        return compact('contentFile', 'scriptFile');
    }
}
