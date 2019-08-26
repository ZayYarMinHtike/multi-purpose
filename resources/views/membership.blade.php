@extends('layouts.app')

@section('content')

<center>
<style>
.signature, .title { 
float:left;
  border-top: 1px solid #000;
  width: 200px; 
  text-align: center;
}
</style>
<div style="width:800px; height:600px; padding:20px; text-align:center; border: 10px solid #787878">
<div style="width:750px; height:550px; padding:20px; text-align:center; border: 5px solid #787878">
       <span style="font-size:50px; font-weight:bold">Certificate of Membership</span>
       <br><br>
       <span style="font-size:25px"><i>This is to certify that</i></span>
       <br><br>
       <span style="font-size:30px"><b>{{ auth()->user()->name }}</b></span><br/><br/>
       <span style="font-size:25px"><i>has accepted as the member of</i></span> <br/><br/>
       <span style="font-size:30px">Myanmar Links Blog</span> <br/><br/>
       <span style="font-size:25px"><i>Certified Date</i></span><br>
       <span style="font-size:25px"><i>{{auth()->user()->created_at}}</i></span>
<table style="margin-top:40px;float:left">
<tr>
<td><span><b>Sayar Soe Thiha Naung</b></td>
</tr>
<tr>
<td style="width:200px;float:left;border:0;border-bottom:1px solid #000;"></td>
</tr>
<tr>
<td style="text-align:center"><span><b>Signature</b></td>
</tr>
</table>
<table style="margin-top:40px;float:right">
<tr>
<td><span><b>{{ auth()->user()->name }}</b></td>
</tr>
<tr>
<td style="width:200px;float:right;border:0;border-bottom:1px solid #000;"></td>
</tr>
<tr>
<td style="text-align:center"><span><b>Signature</b></td>
</tr>
</table>
</div>
</div>
</center>
<br>
      <br>
              <div class="row no-print">
                <div class="col-12 d-flex justify-content-center">
                  <a href="" @click.prevent="printme" target="_blank" class="btn btn-success"><i class="fas fa-print"></i> Print</a>
                </div>
              </div>
      <br>
<br>
@endsection