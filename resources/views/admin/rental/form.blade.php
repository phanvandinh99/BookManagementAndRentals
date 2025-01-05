<div class="box box-info padding-1">
    <div class="box-body">
        <div class="form-group required">
            {{ Form::label('Khách Mượn') }}
            <select name="UserID" class="form-control">
                <option value="">-- Khách Mượn --</option>
                @foreach($users as $user)
                <option value="{{ $user->UserID }}" {{ $user->UserID == $rental->UserID ? 'selected' : '' }}>
                    {{ $user->FirstName }} {{ $user->LastName }} ({{ $user->email }})
                </option>
                @endforeach
            </select>
        </div>

        <!-- Tìm kiếm sách -->
        <div class="form-group">
            <label for="bookSearch">Tìm Mã Sách / <a class="btn-link" href="{{ route('book.create') }}" target="_blank">Thêm Sách Mới</a></label>
            <input type="text" class="form-control" id="bookSearch" placeholder="Nhập tên sách">
            <select id="bookSearchResults" class="form-control" style="margin-top: 10px;">
                <option value="">Kết quả sẽ hiển thị ở đây.</option>
            </select>
        </div>

        <!-- Thông tin sách đã chọn -->
        <div id="selectedBookInfo"></div>

        <!-- Chi tiết hoá đơn -->
        <div class="form-group required">
            <label for="">Chi tiết hoá đơn</label>
            <div class="card">
                <div class="card-body" id="additionalBooks">
                    @if($method != 'PATCH')
                    <div class="card card-info">
                        <div class="card-header">
                            <div class="float-left">
                                <span class="card-title">Thêm Sách</span>
                                <button type="button" class="btn btn-xs btn-danger ml-1" onclick="deleteBookField()">Xoá</button>
                            </div>
                        </div>

                        <div class="card-body">
                            <div class="form-group">
                                <label for="BookID">Mã sách:</label>
                                <input type="text" class="form-control" name="BookID[]" onchange="setTitle()">
                            </div>
                            <div class="form-group">
                                <label for="EndDate">Ngày Kết Thúc Thuê:</label>
                                <input type="datetime-local" class="form-control" name="EndDate[]">
                            </div>
                        </div>
                    </div>
                    @else
                    @foreach($rental->rentaldetails as $rentalDetail)
                    <div class="card card-info">
                        <div class="card-header">
                            <div class="float-left">
                                <span class="card-title">
                                    {{ $rentalDetail->book?->BookTitle ?? 'Sách không xác định' }}
                                </span>
                                <button type="button" class="btn btn-xs btn-danger ml-1" onclick="deleteBookField()">Xoá</button>
                            </div>
                        </div>

                        <div class="card-body">
                            <div class="form-group">
                                <label for="BookID">Mã sách:</label>
                                <input type="text" class="form-control" name="BookID[]" value="{{ $rentalDetail->BookID }}" required>
                            </div>
                            <div class="form-group">
                                <label for="EndDate">Ngày Kết Thúc Thuê:</label>
                                <input type="datetime-local" class="form-control" name="EndDate[]" value="{{ $rentalDetail->EndDate }}" required>
                            </div>
                            <div class="form-group">
                                <label for="Status">Trạng thái:</label>
                                <select class="form-control" name="Status[]" onchange="togglePaymentDate(this)">
                                    <option value="1" {{ $rentalDetail->Status == 1 ? 'selected' : '' }}>Chưa trả</option>
                                    <option value="0" {{ $rentalDetail->Status == 0 ? 'selected' : '' }}>Đã trả</option>
                                </select>
                            </div>

                            <!-- Ô ngày trả chỉ hiển thị khi Status là "Đã trả" (0) -->
                            <div class="form-group payment-date-field" @if($rentalDetail->Status == 0) style="" @else style="display: none;" @endif>
                                <label for="PaymentDate">Ngày trả:</label>
                                <input type="datetime-local" class="form-control" name="PaymentDate[]" value="{{ $rentalDetail->PaymentDate }}">
                            </div>

                        </div>
                    </div>
                    @endforeach

                    @endif
                </div>
            </div>
            <button type="button" class="btn btn-outline-primary btn-sm mb-5" onclick="addBookField()">Thêm</button>
        </div>
    </div>

    <input type="hidden" name="_token" value="{{ csrf_token() }}">
    <div class="box-footer mt20">
        <button type="submit" class="btn btn-primary">{{ __('Xác nhận') }}</button>
    </div>
</div>

@section('formPurchaseOrderScripts')
<script>
    // Hàm debounce để trì hoãn gọi hàm search
    function debounce(func, delay) {
        let timeoutId;
        return function(...args) {
            clearTimeout(timeoutId);
            timeoutId = setTimeout(() => {
                func.apply(this, args);
            }, delay);
        };
    }

    // Hàm tìm kiếm với debounce
    const debouncedSearch = debounce(function(searchTerm) {
        if (searchTerm.trim() !== '') {
            fetch('/api/book/search/' + searchTerm)
                .then(response => response.json())
                .then(data => displaySearchResults(data));
        } else {
            document.getElementById('bookSearchResults').innerHTML = '<option value="">Kết quả sẽ hiển thị ở đây</option>';
        }
    }, 1000); // 1000ms debounce time

    // Event listener cho việc tìm kiếm sách
    document.getElementById('bookSearch').addEventListener('input', function() {
        debouncedSearch(this.value);
    });

    // Hiển thị kết quả tìm kiếm sách
    function displaySearchResults(results) {
        const resultsContainer = document.getElementById('bookSearchResults');
        resultsContainer.innerHTML = '';
        if (results.length > 0) {
            results.forEach(book => {
                const resultOption = document.createElement('option');
                resultOption.value = book.BookID;
                resultOption.textContent = book.BookTitle;
                resultsContainer.appendChild(resultOption);
            });
            displaySelectedBook(results[0]);
        } else {
            resultsContainer.innerHTML = '<option value="">Không tìm thấy cuốn sách nào.</option>';
            document.getElementById('selectedBookInfo').innerHTML = '';
        }
    }

    // Hiển thị thông tin sách đã chọn
    document.getElementById('bookSearchResults').addEventListener('change', function() {
        const selectedBookId = this.value;
        if (selectedBookId) {
            fetch('/api/book/' + selectedBookId)
                .then(response => response.json())
                .then(book => displaySelectedBook(book));
        } else {
            document.getElementById('selectedBookInfo').innerHTML = '';
        }
    });

    // Hiển thị thông tin sách đã chọn
    function displaySelectedBook(book) {
        const selectedBookInfo = document.getElementById('selectedBookInfo');
        selectedBookInfo.innerHTML = `<p><mark>Sách đang chọn: ${book.BookTitle} - Mã sách: <strong>${book.BookID}</strong></mark></p>`;
    }

    // Thêm trường sách mới vào hoá đơn
    function addBookField() {
        const additionalBooks = document.getElementById('additionalBooks');
        const newBookField = document.createElement('div');
        newBookField.innerHTML = `
        <div class="card card-info">
            <div class="card-header">
                <div class="float-left">
                    <span class="card-title"></span>
                    <button type="button" class="btn btn-xs btn-danger ml-1" onclick="deleteBookField()">Xoá</button>
                </div>
            </div>

            <div class="card-body">
                <div class="form-group">
                    <label for="">Mã sách:</label>
                    <input type="text" class="form-control" name="BookID[]" onchange="setTitle()">
                </div>
                <div class="form-group">
                    <label for="">Ngày Trả:</label>
                    <input type="datetime-local" class="form-control" name="EndDate[]">
                </div>
            </div>
        </div>`;
        additionalBooks.appendChild(newBookField);
    }

    // Xoá trường sách
    function deleteBookField() {
        const card = event.currentTarget.closest('.card');
        card.remove();
    }

    // Cập nhật tiêu đề sách khi thay đổi mã sách
    function setTitle() {
        const cardTitle = event.currentTarget.closest('.card').querySelector('.card-title');
        const bookID = event.currentTarget.value;
        if (bookID) {
            fetch('/api/book/' + bookID)
                .then(response => response.json())
                .then(book => cardTitle.innerHTML = book.BookTitle);
        }
    }

    // Kiểm tra form và gửi dữ liệu
    document.getElementById('submitBtn').addEventListener('click', function(event) {
        event.preventDefault();
        if (validateForm()) {
            document.querySelector('form').submit();
        }
    });

    // Kiểm tra trùng lặp trong danh sách
    function hasDuplicates(array) {
        return new Set(array).size !== array.length;
    }

    // Kiểm tra tính hợp lệ của form
    function validateForm() {
        const orderDate = document.getElementsByName('OrderDate')[0];
        const userID = document.getElementsByName('UserID')[0];
        const bookIds = document.getElementsByName('BookID[]');
        const listId = Array.from(bookIds).map(id => id.value);

        if (!orderDate.value) {
            alert('Vui lòng chọn Ngày nhập.');
            orderDate.focus();
            return false;
        }
        if (!userID.value) {
            alert('Vui lòng chọn Nhà cung cấp.');
            userID.focus();
            return false;
        }
        if (hasDuplicates(listId)) {
            alert("Mã sách không được trùng nhau!");
            return false;
        }

        const quantityReceived = document.getElementsByName('QuantityReceived[]');
        const price = document.getElementsByName('EndDate[]');

        for (let i = 0; i < quantityReceived.length; i++) {
            if (!quantityReceived[i].value || !price[i].value) {
                alert('Vui lòng điền đầy đủ thông tin cho tất cả các sách.');
                return false;
            }
        }

        if (quantityReceived.length === 0) {
            alert('Vui lòng thêm sách vào hoá đơn.');
            return false;
        }

        return true;
    }
</script>
@endsection