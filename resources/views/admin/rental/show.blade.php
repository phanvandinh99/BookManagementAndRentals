@extends('admin.layout.default')

@section('template_title')
{{ "Hoá đơn mượn $rental->RentalID" }}
@endsection

@section('content')
<section class="content container-fluid">
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header">
                    <div class="float-left">
                        <span class="card-title">{{ __('Thông tin') }} hoá đơn mượn trả</span>
                    </div>
                    <div class="float-right">
                        <a href="{{ route('rental.edit', $rental->RentalID) }}" class="btn btn-outline-primary"><i class="fa-solid fa-pen"></i> Sửa thông tin</a>
                        <a class="btn btn-primary" href="{{ route('rental.index') }}"> {{ __('Quay lại') }}</a>
                    </div>
                </div>
                @if ($message = Session::get('success'))
                <div class="alert alert-success">
                    <p>{{ $message }}</p>
                </div>
                @endif

                <div class="card-body">

                    <div class="form-group">
                        <strong>Mã thuê sách:</strong>
                        {{ $rental->RentalID }}
                    </div>
                    <div class="form-group">
                        <strong>Người Mượn</strong>
                        {{ $rental->user->FirstName }} {{ $rental->user->LastName }} (email: {{ $rental->user->email }})
                    </div>
                    <div class="form-group">
                        <strong>Ngày Mượn</strong>
                        {{ $rental->DateCreated }}
                    </div>
                    <div class="form-group">
                        <strong>Tổng Tiền Sách</strong>
                        {{ number_format($rental->TotalBookCost, 0, ',', '.') }} VND
                    </div>
                    <div class="form-group">
                        <strong>Tổng Giá Thuê</strong>
                        {{ number_format($rental->TotalRentalPrice, 0, ',', '.') }} VND
                    </div>
                    <div class="form-group">
                        <strong>Tổng Tiền</strong>
                        {{ number_format($rental->TotalPrice, 0, ',', '.') }} VND
                    </div>
                </div>
            </div>

            <div class="card">
                <div class="card-header">
                    <div class="float-left">
                        <span class="card-title">Sách Đã Mượn</span>
                    </div>
                </div>

                <div class="card-body">
                    @foreach($rentalDetails as $rentalDetail)
                    <div class="card card-info">
                        <div class="card-header">
                            <div class="float-left">
                                <span class="card-title">{{ $rentalDetail->book->BookTitle }}</span>
                            </div>
                        </div>

                        <div class="card-body">

                            <div class="form-group">
                                <strong>Số lượng:</strong>
                                1
                            </div>
                            <div class="form-group">
                                <strong>Ngày Kết Thúc Thuê Sách:</strong>
                                {{ \Carbon\Carbon::parse($rentalDetail->EndDate)->format('H:i d/m/Y') }}
                            </div>
                            <div class="form-group">
                                <strong>Trạng Thái:</strong>
                                @if ($rentalDetail->Status == 0)
                                Đã trả
                                <div class="form-group">
                                    <strong>Ngày trả:</strong>
                                    {{ \Carbon\Carbon::parse($rentalDetail->PaymentDate)->format('H:i d/m/Y') }}
                                </div>

                                @if (\Carbon\Carbon::parse($rentalDetail->PaymentDate)->greaterThan(\Carbon\Carbon::parse($rentalDetail->EndDate)))
                                <div class="form-group">
                                    <span class="text-danger"><strong>Vi phạm trả trễ hẹn</strong></span>
                                    @php
                                    $lateDays = \Carbon\Carbon::parse($rentalDetail->EndDate)->diffInDays(\Carbon\Carbon::parse($rentalDetail->PaymentDate));
                                    $lateFee = $lateDays * 2000;
                                    @endphp
                                    <p>Thời gian trả trễ: {{ $lateDays }} ngày</p>
                                    <p>Phí trả trễ: {{ number_format($lateFee, 0, ',', '.') }} đ</p>
                                </div>
                                @endif
                                @elseif ($rentalDetail->Status == 1)
                                Chưa trả
                                @else
                                Không rõ
                                @endif
                            </div>

                        </div>
                    </div>

                </div>

                @endforeach
            </div>
        </div>

    </div>
    </div>
</section>
@endsection