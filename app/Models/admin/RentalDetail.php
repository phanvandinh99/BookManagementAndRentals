<?php

namespace App\Models\admin;

use Illuminate\Database\Eloquent\Model;

/**
 * Class RentalDetail
 *
 * @property int $RentalDetailID
 * @property int|null $RentalID
 * @property int|null $BookID
 * @property int|null $BookCode
 * @property int|null $Quantity
 * @property \Illuminate\Support\Carbon|null $StartDate
 * @property \Illuminate\Support\Carbon|null $EndDate
 * @property \Illuminate\Support\Carbon|null $PaymentDate
 * @property int|null $Status
 * 
 * @property Rental $rental
 * @property Book $book
 */
class RentalDetail extends Model
{
    protected $table = 'rentaldetail'; // Tên bảng
    protected $primaryKey = 'RentalDetailID'; // Khóa chính

    public $timestamps = false; // Không sử dụng timestamps

    protected $fillable = [
        'RentalID',
        'BookID',
        'BookCode',
        'Quantity',
        'StartDate',
        'EndDate',
        'PaymentDate',
        'Status',
    ];

    // Quan hệ với bảng Rental (một RentalDetail thuộc một Rental)
    public function rental()
    {
        return $this->belongsTo('App\Models\admin\Rental', 'RentalID', 'RentalID');
    }

    // Quan hệ với bảng Book (một RentalDetail thuộc một Book)
    public function book()
    {
        return $this->belongsTo('App\Models\admin\Book', 'BookID', 'BookID');
    }
}
