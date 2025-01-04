<?php

namespace App\Http\Controllers\admin;

use App\Models\admin\RentalDetail;
use Illuminate\Http\Request;

/**
 * Class RentalDetailController
 * @package App\Http\Controllers
 */
class RentalDetailController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $rentalDetails = RentalDetail::paginate();

        return view('rental-detail.index', compact('rentalDetails'))
            ->with('i', (request()->input('page', 1) - 1) * $rentalDetails->perPage());
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        $rentalDetail = new RentalDetail();
        return view('rental-detail.create', compact('rentalDetail'));
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $rentalDetail = RentalDetail::create($request->all());

        return redirect()->route('rental-details.index')
            ->with('success', 'RentalDetail created successfully.');
    }

    /**
     * Display the specified resource.
     *
     * @param  int $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $rentalDetail = RentalDetail::find($id);

        return view('rental-detail.show', compact('rentalDetail'));
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $rentalDetail = RentalDetail::find($id);

        return view('rental-detail.edit', compact('rentalDetail'));
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request $request
     * @param  \App\Models\admin\RentalDetail $rentalDetail
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, RentalDetail $rentalDetail)
    {
        $rentalDetail->update($request->all());

        return redirect()->route('rental-details.index')
            ->with('success', 'RentalDetail updated successfully');
    }

    /**
     * @param int $id
     * @return \Illuminate\Http\RedirectResponse
     * @throws \Exception
     */
    public function destroy($id)
    {
        $rentalDetail = RentalDetail::find($id)->delete();

        return redirect()->route('rental-details.index')
            ->with('success', 'RentalDetail deleted successfully');
    }
}
