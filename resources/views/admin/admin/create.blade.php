@extends('admin.layout.default')

@section('template_title')
    {{ __('Thêm mới quản trị viên') }}
@endsection

@php
    $method = "POST";
@endphp

@section('content')
    <section class="content container-fluid">
        <div class="row">
            <div class="col-md-12">

                @includeif('partials.errors')

                <div class="card card-default">
                    <div class="card-header">
                        <div class="float-left">
                            <span class="card-title">{{ __('Thêm mới') }}</span>
                        </div>
                        <div class="float-right">
                            <a class="btn btn-primary" href="{{ route('admin.index') }}"> {{ __('Back') }}</a>
                        </div>
                    </div>
                    <div class="card-body">
                        <form method="POST" action="{{ route('admin.store') }}" role="form"
                              enctype="multipart/form-data">
                            @csrf

                            @include('admin.admin.form')

                        </form>
                    </div>
                </div>
            </div>
        </div>
    </section>
@endsection
