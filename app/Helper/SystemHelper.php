<?php

namespace App\Helpers;

use DateTime;

class SystemHelper
{
    # -------------------------------------------------------------
    /**
     * Returns a human-readable time difference from a given date.
     *
     * @param string $dateTime The date string.
     * @return string The elapsed time string.
     */
    public static function timeElapsedString($dateTime)
    { 
        $timestamp = strtotime($dateTime);
        if ($timestamp === false) {
            return 'Invalid date';
        }
    
        $currentTimestamp = time();
        $diffSeconds = $currentTimestamp - $timestamp;
    
        if ($diffSeconds > 86400) {
            return date('M j, Y \a\t h:i:s A', $timestamp);
        }
    
        $intervals = [
            31536000 => 'year',
            2592000 => 'month',
            604800 => 'week',
            86400 => 'day',
            3600 => 'hour',
            60 => 'minute',
            1 => 'second'
        ];
    
        if ($diffSeconds < 60) {
            return 'Just Now';
        }
    
        foreach ($intervals as $seconds => $label) {
            $count = floor($diffSeconds / $seconds);
            if ($count > 0) {
                return sprintf('%d %s ago', $count, $label . ($count > 1 ? 's' : ''));
            }
        }
    
        return date('M j, Y \a\t h:i:s A', $timestamp);
    }
    # -------------------------------------------------------------

    # -------------------------------------------------------------
    /**
     * Compares the difference between two dates in years and months.
     *
     * @param string $startDateTime Start date in 'd F Y' format.
     * @param string $endDateTime End date in 'd F Y' format.
     * @return string Time difference in years and months.
     */
    public static function yearMonthElapsedComparisonString($startDateTime, $endDateTime)
    {
        $startDate = DateTime::createFromFormat('d F Y', '01 ' . $startDateTime);
        $endDate = DateTime::createFromFormat('d F Y', '01 ' . $endDateTime);

        if ($startDate && $endDate) {
            $interval = $startDate->diff($endDate);
            $years = $interval->y;
            $months = $interval->m;

            $elapsedTime = [];
            if ($years > 0) {
                $elapsedTime[] = $years . ' ' . ($years === 1 ? 'year' : 'years');
            }
            if ($months > 0) {
                $elapsedTime[] = $months . ' ' . ($months === 1 ? 'month' : 'months');
            }

            return $elapsedTime ? implode(' and ', $elapsedTime) : 'Just Now';
        }
        return 'Error parsing dates';
    }
    # -------------------------------------------------------------

    # -------------------------------------------------------------
    /**
     * Formats and modifies a given date based on the type.
     *
     * @param string $format The format to use for the date.
     * @param string $date The date to format.
     * @param string|null $modify Optional modification to apply to the date.
     * @return string The formatted date string.
     */
    public static function formatDate($format, $date, $modify = null)
    {
        $dateTime = new DateTime($date);
        if ($modify) {
            $dateTime->modify($modify);
        }
        return $dateTime->format($format);
    }
    # -------------------------------------------------------------

    # -------------------------------------------------------------
    /**
     * Returns a default value based on the type.
     *
     * @param string $type The type of value to return.
     * @param string $systemDate The current system date.
     * @param string $systemTime The current system time.
     * @return mixed Default value based on the type.
     */
    public static function getDefaultReturnValue($type, $systemDate, $systemTime)
    {
        switch ($type) {
            case 'default':
                return $systemDate;
            case 'empty':
            case 'attendance empty':
            case 'summary':
                return null;
            case 'na':
                return 'N/A';
            case 'complete':
            case 'encoded':
            case 'date time':
                return 'N/A';
            case 'default time':
                return $systemTime;
            default:
                return null;
        }
    }
    # -------------------------------------------------------------

    # -------------------------------------------------------------
    /**
     * Checks if time is needed for a specific type.
     *
     * @param string $type The type to check.
     * @return bool True if time is needed, false otherwise.
     */
    private static function needsTime($type)
    {
        return in_array($type, ['complete', 'encoded', 'date time']);
    }
    # -------------------------------------------------------------

    # -------------------------------------------------------------
    /**
     * Returns a default image based on the provided type.
     *
     * @param string $type The type of the image (e.g. 'profile', 'login logo').
     * @return string The URL of the default image.
     */
    public static function getDefaultImage($type)
    {
        $defaultImages = [
            'profile' => DEFAULT_AVATAR_IMAGE,
            'login background' => DEFAULT_BG_IMAGE,
            'login logo' => DEFAULT_LOGIN_LOGO_IMAGE,
            'menu logo' => DEFAULT_MENU_LOGO_IMAGE,
            'module icon' => DEFAULT_MODULE_ICON_IMAGE,
            'favicon' => DEFAULT_FAVICON_IMAGE,
            'company logo' => DEFAULT_COMPANY_LOGO,
            'id placeholder front' => DEFAULT_ID_PLACEHOLDER_FRONT,
            'app module logo' => DEFAULT_APP_MODULE_LOGO,
            'upload placeholder' => DEFAULT_UPLOAD_PLACEHOLDER,
        ];

        return $defaultImages[$type] ?? DEFAULT_PLACEHOLDER_IMAGE;
    }
    # -------------------------------------------------------------

    # -------------------------------------------------------------
    /**
     * Checks if the provided image exists, otherwise returns a default image.
     *
     * @param string $image The image path.
     * @param string $type The type of the image (used for default).
     * @return string The image path or default image.
     */
    public static function checkImage($image, $type)
    {
        $image = $image ?? '';
        $imagePath = str_replace('./apps/', '../../../../apps/', $image);

        return (empty($image) || !file_exists($imagePath) && !file_exists($image))
            ? self::getDefaultImage($type)
            : $image;
    }
    # -------------------------------------------------------------

    # -------------------------------------------------------------
    /**
     * Returns the appropriate icon for a given file extension.
     *
     * @param string $type The file extension (e.g. 'jpg', 'pdf').
     * @return string The file icon path.
     */
    public static function getFileExtensionIcon($type)
    {
        $defaultImages = [
            'ai' => './assets/images/file-icon/img-file-ai.svg',
            'doc' => './assets/images/file-icon/img-file-doc.svg',
            'docx' => './assets/images/file-icon/img-file-doc.svg',
            'jpeg' => './assets/images/file-icon/img-file-img.svg',
            'jpg' => './assets/images/file-icon/img-file-img.svg',
            'png' => './assets/images/file-icon/img-file-img.svg',
            'gif' => './assets/images/file-icon/img-file-img.svg',
            'pdf' => './assets/images/file-icon/img-file-pdf.svg',
            'ppt' => './assets/images/file-icon/img-file-ppt.svg',
            'pptx' => './assets/images/file-icon/img-file-ppt.svg',
            'rar' => './assets/images/file-icon/img-file-rar.svg',
            'txt' => './assets/images/file-icon/img-file-txt.svg',
            'xls' => './assets/images/file-icon/img-file-xls.svg',
            'xlsx' => './assets/images/file-icon/img-file-xls.svg',
        ];

        return $defaultImages[$type] ?? './assets/images/file-icon/img-file-img.svg';
    }
    # -------------------------------------------------------------

    # -------------------------------------------------------------
    /**
     * Converts bytes to a human-readable format.
     *
     * @param int $bytes The number of bytes.
     * @param int $precision The number of decimal places (default is 2).
     * @return string The formatted byte size.
     */
    public static function getFormatBytes($bytes, $precision = 2)
    {
        $units = ['B', 'Kb', 'Mb', 'Gb', 'Tb', 'Pb', 'Eb', 'Zb', 'Yb'];

        $bytes = max($bytes, 0);
        $pow = floor(log($bytes ?: 1, 1024));
        return round($bytes / (1 << (10 * $pow)), $precision) . ' ' . $units[$pow];
    }
    # -------------------------------------------------------------

    # -------------------------------------------------------------
    /**
     * Generates HTML option elements for months.
     *
     * @return string The generated HTML for month options.
     */
    public static function generateMonthOptions()
    {
        $months = [
            'January', 'February', 'March', 'April',
            'May', 'June', 'July', 'August',
            'September', 'October', 'November', 'December'
        ];

        return implode('', array_map(function($month) {
            return "<option value=\"$month\">$month</option>";
        }, $months));
    }
    # -------------------------------------------------------------

    # -------------------------------------------------------------
    /**
     * Generates HTML option elements for years.
     *
     * @param int $start The start year.
     * @param int $end The end year.
     * @return string The generated HTML for year options.
     */
    public static function generateYearOptions($start, $end)
    {
        return implode('', array_map(function($year) {
            return "<option value=\"$year\">$year</option>";
        }, range($start, $end)));
    }
    # -------------------------------------------------------------
}

?>