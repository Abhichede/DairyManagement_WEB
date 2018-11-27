$(function () {
    $('table#total_collections_table').DataTable();

    $('#from_date_payment_register').datetimepicker({
        format: 'DD-MM-YYYY',
        icons: {
            time: "fa fa-clock-o",
            date: "fa fa-calendar",
            up: "fa fa-arrow-up",
            down: "fa fa-arrow-down"
        }
    });
    $('#to_date_payment_register').datetimepicker({
        format: 'DD-MM-YYYY',
        icons: {
            time: "fa fa-clock-o",
            date: "fa fa-calendar",
            up: "fa fa-arrow-up",
            down: "fa fa-arrow-down"
        }
    });
});
$('div#daily_collection_form').ready(function () {
    var d = new Date();
    var hours = d.getHours();

    if(hours < 12 ){
        $("input#daily_collection_shift").val("Morning");
    }else{
        $("input#daily_collection_shift").val("Evening");
    }

    getCustomerID();
});

function getCustomerID() {
    var customer_id = $('.selectpicker#daily_collection_customer_id option:selected').val();
    console.log(customer_id);
    if(customer_id != null && customer_id !== 0 && customer_id !== '') {
        $.ajax({
            url: "/customers/" + customer_id + ".json", success: function (result) {
                $("input#daily_collection_cattle_type").val(result.cattle_type);
            }
        });
    }
}

function calculateSNF(lacto) {
    var litres = $("input#daily_collection_litre").val();
    var fat = $("input#daily_collection_fat").val();
    var cattle_type = $("input#daily_collection_cattle_type").val();

    lacto = lacto.value;

    if(cattle_type === null || cattle_type === '' || cattle_type === 0){
        $("#error_ModalLabel").html("ERROR !!!");
        $("#error_modalText").html("Please select one of the customer first.");

        $("#errorModal").modal("show");
    }else if(litres === null || litres === '' || litres === 0){
        $("#error_ModalLabel").html("ERROR !!!");
        $("#error_modalText").html("Please Enter Litres first.");

        $("#errorModal").modal("show");
    }else if(!isValidNumber(litres)){
        $("#error_ModalLabel").html("ERROR !!!");
        $("#error_modalText").html("Please Enter valid litre value.");

        $("#errorModal").modal("show");
    }else if(fat === null || fat === '' || fat === 0){
        $("#error_ModalLabel").html("ERROR !!!");
        $("#error_modalText").html("Please Enter FAT first.");

        $("#errorModal").modal("show");
    }else if(!isValidNumber(fat)){
        $("#error_ModalLabel").html("ERROR !!!");
        $("#error_modalText").html("Please Enter valid FAT value.");

        $("#errorModal").modal("show");
    }else if(!isValidNumber(lacto)){
        $("#error_ModalLabel").html("ERROR !!!");
        $("#error_modalText").html("Please Enter valid Lacto value.");

        $("#errorModal").modal("show");
    }else{

        var snf = lacto / 4.0 + 0.21 * fat + 0.36;

        $("input#daily_collection_snf").val(accounting.toFixed(snf, 1));

        $.ajax({url: "/rate_by_snf_and_fat.json?snf="+ parseFloat(accounting.toFixed(snf, 1)) +"&" +
                "fat="+ parseFloat(fat).toPrecision(3)+"&cattle_type="+ cattle_type,
            success: function(result){
                console.log(result);
                var rate = result.rate;
                $("input#daily_collection_rate").val(rate);
                $("input#daily_collection_total_price").val(rate * litres);
            }});
    }
}


function isValidNumber(number){
    var numberPattern = new RegExp('[0-9]+([\\.,][0-9]+)?');

    return numberPattern.test(number);
}