<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateMedicinesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {

        Schema::create('medicines', function (Blueprint $table) {
            $table->bigIncrements('id')->unsigned();
            $table->string('scientific_name');
            $table->string('commercial_name');
            $table->string('manufacture_company');
            $table->integer('Available_quantity');
            $table->dateTime('Expiration_date');
            $table->bigInteger('price');
            $table->timestamps();
            $table->softDeletes();
        });

       
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('medicines');
    }
}
