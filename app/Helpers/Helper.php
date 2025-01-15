<?php

if (!function_exists('set_active')) {
    function set_active($route)
    {
        return \Illuminate\Support\Facades\Route::is($route) ? 'active' : '';
    }
}

if (!function_exists('formatVND')) {
    function formatVND($amount)
    {
        return number_format($amount, 0, ',', '.') . ' vnđ';
    }
}
