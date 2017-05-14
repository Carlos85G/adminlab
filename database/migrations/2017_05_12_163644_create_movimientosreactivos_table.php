<?php

use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateMovimientosreactivosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
      Schema::create('movimientosreactivos', function (Blueprint $table) {
          $table->increments('id');
          $table->integer('reactivo_id')->unsigned();
          $table->decimal('cantidad', 10, 2)->default(1.00);
          $table->unsignedInteger('asignable_id');
          $table->string('asignable_type');
          $table->timestamp('deleted_at')->nullable()->default(null);
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
        Schema::drop('movimientosreactivos');
    }
}
