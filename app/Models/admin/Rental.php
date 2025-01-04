<?php

namespace App\Models\admin;

use Illuminate\Database\Eloquent\Model;

/**
 * Class Rental
 *
 * @property int $RentalID
 * @property int|null $UserID
 * @property \Illuminate\Support\Carbon|null $DateCreated
 * @property int $Status
 * @property float|null $TotalBookCost
 * @property float|null $TotalRentalPrice
 * @property float|null $TotalPrice
 *
 * @property \Illuminate\Database\Eloquent\Collection|RentalDetail[] $rentalDetails
 * @property User $user
 */
class Rental extends Model
{
    protected $table = 'rental'; // Tên bảng
    protected $primaryKey = 'RentalID'; // Khóa chính

    public $timestamps = false; // Không sử dụng timestamps
    public $incrementing = true; // Khóa chính tự tăng

    // Quy tắc validation
    static $rules = [
        'UserID' => 'nullable|integer',
        'TotalBookCost' => 'nullable|numeric',
        'TotalRentalPrice' => 'nullable|numeric',
        'TotalPrice' => 'nullable|numeric',
    ];

    protected $fillable = [
        'UserID',
        'DateCreated',
        'Status',
        'TotalBookCost',
        'TotalRentalPrice',
        'TotalPrice',
    ];

    // Quan hệ với bảng User (một Rental thuộc về một User)
    public function user()
    {
        return $this->belongsTo('App\Models\admin\User', 'UserID', 'UserID');
    }

    // Quan hệ với bảng RentalDetail (một Rental có nhiều RentalDetail)
    public function rentalDetails()
    {
        return $this->hasMany('App\Models\admin\RentalDetail', 'RentalID', 'RentalID');
    }
}
