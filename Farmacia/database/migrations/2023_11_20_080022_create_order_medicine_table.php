<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('order_medicine', function (Blueprint $table) {
            $table->bigIncrements('id')->unsigned();
            $table->foreignId('order_id')->references('id')->on('orders');
            $table->foreignId('medicine_id')->references('id')->on('medicines');
            $table->integer('required_quantity');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('order_medicine');
    }
};
