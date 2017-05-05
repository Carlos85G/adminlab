<?php

use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreatePracticasreactivosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('practicasreactivos', function (Blueprint $table) {
            $table->increments('id');
            $table->integer('practica_id')->unsigned();
            $table->integer('reactivo_id')->unsigned();
            $table->decimal('cantidad', 10, 2)->default(1.00)->unsigned();
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
        Schema::drop('practicasreactivos');
    }
}
