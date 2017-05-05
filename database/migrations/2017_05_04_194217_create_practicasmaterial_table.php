<?php

use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateTablePracticasmaterial extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('practicasmateriales', function (Blueprint $table) {
            $table->increments('id');
            $table->integer('practica_id', 10)->unsigned();
            $table->integer('material_id', 10)->unsigned();
            $table->integer('cantidad', 10)->default(1)->unsigned();
            $table->boolean('por_practica')->default(false);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::drop('practicasmateriales');
    }
}
