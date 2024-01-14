<?php

namespace App\Http\Resources;

use App\Models\API\Medicine;
use App\Models\API\Order_Medicine;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class OrdersResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    static $lang;

    public function toArray(Request $request): array
    {
        //$request->route()->getName() == "show_one_web"
        $lang = self::$lang;
        $translat = ['preparing' => 'قيد التحضير' , 'has been sent' => 'تم الارسال' , 'recived' => 'مستلمة'];
        $name = User::find($this->user_id);
        $meds = Order_Medicine::where('order_id' , $this->id)->get();
        $Total_Price = 0;
        foreach($meds as $med){
            $item = Medicine::find($med->medicine_id);
            $Total_Price += $med->required_quantity*$item->price;
        }
        return ( $request->user()->Is_admin == 1) ?
        
        [
            'name' => $name->username,
            'Order_Id' => $this->id,
            'State' => $this->order_state,
            'Payment_State' => $this->payment_status,
            'Creation_Date' => $this->created_at->format('Y-m-d'),
            'Total_Price' => $Total_Price
        ]: (($lang != "ab") ?
         [
            'Order_Id' => $this->id,
            'State' => $this->order_state,
        ] : [
            'Order_Id' => $this->id,
            'State' => $translat[$this->order_state],
        ]);
    }
}
