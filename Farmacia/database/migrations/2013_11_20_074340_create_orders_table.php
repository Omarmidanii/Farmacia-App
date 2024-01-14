<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateOrdersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::disableForeignKeyConstraints();

        Schema::create('orders', function (Blueprint $table) {
            $table->bigIncrements('id')->unsigned();
            $table->foreignId('user_id')->references('id')->on('users');
            $table->enum('order_state' , ['preparing' , 'has been sent' , 'recived'])->default('preparing');
            $table->enum('payment_status', ['paid' , 'Unpaid'])->default('Unpaid');
            $table->timestamps();
            $table->softDeletes();
        });

        Schema::enableForeignKeyConstraints();
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('orders');
    }
}
