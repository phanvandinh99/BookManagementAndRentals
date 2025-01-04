@extends('admin.layout.default')

@section('template_title')
Hoá đơn mượn sách
@endsection

@section('content')
<div class="row">
    <div class="col-sm-12">
        <div class="card">
            <div class="card-header d-flex justify-content-between align-items-center">
                <div class="btn-group">
                    <button class="btn btn-secondary dropdown-toggle" type="button" id="exportData"
                        data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        Xuất dữ liệu
                    </button>
                    <div class="dropdown-menu">
                        <a class="dropdown-item" href="#" onclick="exportToExcel()">Excel</a>
                    </div>
                </div>

                <form id="searchForm" action="{{ route('rental.index') }}" method="GET" class="d-inline-block">
                    <input type="text" name="search" class="form-control" placeholder="Tìm kiếm mã hoá đơn..."
                        value="{{ request('search') }}">
                </form>

                <a href="{{ route('rental.create') }}" class="btn btn-primary">
                    Thêm phiếu mượn sách
                </a>
            </div>

            @if ($message = Session::get('success'))
            <div class="alert alert-success mt-3">
                {{ $message }}
            </div>
            @endif

            <div class="card-body">
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>Mã Thuê Sách</th>
                            <th>Khách Mượn</th>
                            <th>Ngày Mượn</th>
                            <th>Giá Trị Sách Mượn</th>
                            <th>Phí Thuê Sách (2.000đ/ngày)</th>
                            <th>Tổng Tiền</th>
                        </tr>
                    </thead>
                    <tbody>
                        @forelse ($rentals as $rental)
                        <tr>
                            <td>{{ $rental->RentalID }}</td>
                            <td>{{ $rental->user->FirstName }} {{ $rental->user->LastName }}  (email: {{ $rental->user->email }})</td> <!-- Tên người dùng -->
                            <td>{{ $rental->DateCreated }}</td>
                            <td>{{ number_format($rental->TotalBookCost, 0, ',', '.') }} VND</td> <!-- Định dạng tiền VND -->
                            <td>{{ number_format($rental->TotalRentalPrice, 0, ',', '.') }} VND</td> <!-- Định dạng tiền VND -->
                            <td>{{ number_format($rental->TotalPrice, 0, ',', '.') }} VND</td> <!-- Định dạng tiền VND -->
                            <td></td>
                            <td>
                                <a class="btn btn-sm btn-primary" href="{{ route('rental.show', $rental->RentalID) }}">
                                    Xem
                                </a>
                                <a class="btn btn-sm btn-success" href="{{ route('rental.edit', $rental->RentalID) }}">
                                    Sửa
                                </a>
                                <form action="{{ route('rental.destroy', $rental->RentalID) }}" method="POST"
                                    style="display: inline-block;">
                                    @csrf
                                    @method('DELETE')
                                    <button type="submit" class="btn btn-sm btn-danger"
                                        onclick="return confirm('Bạn có chắc chắn muốn xóa?')">
                                        Xóa
                                    </button>
                                </form>
                            </td>
                        </tr>
                        @empty
                        <tr>
                            <td colspan="4" class="text-center">Không có dữ liệu</td>
                        </tr>
                        @endforelse

                    </tbody>
                </table>
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        Hiển thị {{ $rentals->firstItem() }} đến {{ $rentals->lastItem() }} trong tổng số {{ $rentals->total() }} bản ghi
                    </div>
                    <div>
                        {!! $rentals->links() !!}
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection

@section('exportToExcelScripts')
<script>
    function exportToExcel() {
        let tableName = 'rental';
        let apiUrl = `/api/${tableName}/all`;
        alert('Đang xuất thành file ' + tableName + '.xlsx');
        // Lấy dữ liệu từ API
        fetch(apiUrl)
            .then(response => response.json())
            .then(data => {
                // Chuyển đổi dữ liệu thành định dạng Excel
                const workbook = XLSX.utils.book_new();
                const worksheet = XLSX.utils.json_to_sheet(data);
                XLSX.utils.book_append_sheet(workbook, worksheet, tableName);

                // Xuất Excel
                XLSX.writeFile(workbook, tableName + '.xlsx');
            })
            .catch(error => {
                console.error('Error fetching data:', error);
            });
    }
</script>
@endsection