<?php

namespace App\Models\admin;

use Illuminate\Database\Eloquent\Model;

/**
 * Class Rental
 *
 * @property int $RentalID
 * @property int|null $UserID
 * @property \Carbon\Carbon|null $DateCreated
 * @property int $Status
 * @property float|null $TotalBookCost
 * @property float|null $TotalRentalPrice
 * @property float|null $TotalPrice
 *
 * @property User $user
 * @package App
 * @mixin \Illuminate\Database\Eloquent\Builder
 */
class Rental extends Model
{
    // Tên bảng trong cơ sở dữ liệu
    protected $table = "rental";

    // Khóa chính của bảng
    protected $primaryKey = "RentalID";

    // Loại bỏ các cột timestamps nếu không sử dụng
    public $timestamps = false;

    // Đặt khóa chính là tự tăng
    public $incrementing = true;

    // Quy tắc validation
    static $rules = [
        'UserID' => 'nullable|integer',
        'TotalBookCost' => 'nullable|numeric',
        'TotalRentalPrice' => 'nullable|numeric',
        'TotalPrice' => 'nullable|numeric',
    ];

    // Số bản ghi trên mỗi trang (nếu sử dụng phân trang)
    protected $perPage = 20;

    // Các thuộc tính có thể gán giá trị bằng cách sử dụng phương thức create() hoặc fill()
    protected $fillable = [
        'UserID',
        'DateCreated',
        'Status',
        'TotalBookCost',
        'TotalRentalPrice',
        'TotalPrice',
    ];

    /**
     * Định nghĩa mối quan hệ với model User.
     * 
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function user()
    {
        return $this->belongsTo('App\Models\admin\User', 'UserID', 'UserID');
    }
}
