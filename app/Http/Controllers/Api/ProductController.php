<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Product;
use Illuminate\Http\Request;

class ProductController extends Controller
{
    /**
     * @var Product
     */
    private $product;

    public function __construct(Product $product)
    {
        $this->product = $product;
    }

    public function index(): \Illuminate\Http\JsonResponse
    {

        return response()->json($this->product->all());

    }

    public function get($id): \Illuminate\Http\JsonResponse
    {
        $product = $this->product->find($id);
        return response()->json($product);
    }

    public function save(Request $request): \Illuminate\Http\JsonResponse
    {
        $product_data = $request->all();
        $product = $this->product->create($product_data);
        return response()->json($product);
    }
}
