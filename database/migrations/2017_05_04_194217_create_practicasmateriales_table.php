<?php

use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateTablePracticasmateriales extends Migration
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
            $table->integer('practica_id')->unsigned();
            $table->integer('material_id')->unsigned();
            $table->integer('cantidad')->default(1)->unsigned();
            $table->boolean('por_grupo')->default(false);
            $table->timestamp('deleted_at')->default(null);
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
