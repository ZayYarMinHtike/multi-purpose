<?php

use Illuminate\Database\Seeder;
use App\User;

class AllUserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        
        User::create([
            'name' => 'zymh',
            'email' => 'zymh@gmail.com',
            'password' => Hash::make("123456"),
            'type' => 'admin',
        ]);

        User::create([
            'name' => 'drzymh',
            'email' => 'drzymh@gmail.com',
            'password' => Hash::make("123456"),
            'type' => 'admin',
        ]);
    }
}
