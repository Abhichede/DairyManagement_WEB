$(function () {
    $('table#total_collections_table').DataTable();
    $('#table_current_collection').DataTable({
        scrollY: 400,
        order: false
    });

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

    $('form#daily_collection_form').validate();

    $('input#daily_collection_lacto').on('keypress', function (e) {
        if(e.which === 13){
            calculateSNF($('input#daily_collection_lacto').val());
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

    //lacto = lacto.value;
    console.log(lacto);

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
        calculateSNFAndUpdateRate(fat, lacto, litres, cattle_type);
    }
}

function afterLitreUpdate() {
    var litres = $("input#daily_collection_litre").val();
    var fat = $("input#daily_collection_fat").val();
    var lacto = $("input#daily_collection_lacto").val();
    var cattle_type = $("input#daily_collection_cattle_type").val();

    if(cattle_type === null || cattle_type === '' || cattle_type === 0){
        $("#error_ModalLabel").html("ERROR !!!");
        $("#error_modalText").html("Please select one of the customer first.");

        $("#errorModal").modal("show");
    }else if((litres !== null && litres !== '' && litres !== 0) &&
        (fat !== null && fat !== '' && fat !== 0) &&
        (lacto !== null && lacto !== '' && lacto !== 0)){
        if(!isValidNumber(litres) && !isValidNumber(fat) && !isValidNumber(lacto)){
            $("#error_ModalLabel").html("ERROR !!!");
            $("#error_modalText").html("Please Enter valid litre / FAT / Lacto value.");

            $("#errorModal").modal("show");
        }else{
            calculateSNFAndUpdateRate(fat, lacto, litres, cattle_type)
        }
    }
}


function isValidNumber(number){
    var numberPattern = new RegExp('[0-9]+([\\.,][0-9]+)?');

    return numberPattern.test(number);
}

function calculateSNFAndUpdateRate(fat, lacto, litres, cattle_type) {
    var snf = lacto / 4.0 + 0.21 * fat + 0.36;

    $("input#daily_collection_snf").val(accounting.toFixed(snf, 1));

    $.ajax({url: "/rate_by_snf_and_fat.json?snf="+ parseFloat(accounting.toFixed(snf, 1)) +"&" +
            "fat="+ parseFloat(fat).toPrecision(3)+"&cattle_type="+ cattle_type,
        success: function(result){
            console.log(result);
            var rate = result.rate;
            if(rate === null || rate === 0 || rate === ''){
                $("#error_ModalLabel").html("Warning !!!");
                $("#error_modalText").html("No rate found.");

                $("#errorModal").modal("show");
            }else if(result.error){
                $("#error_ModalLabel").html("Warning !!!");
                $("#error_modalText").html(result.error);

                $("#errorModal").modal("show");
            }else {
                $("input#daily_collection_rate").val(rate);
                $("input#daily_collection_total_price").val(accounting.toFixed((rate * litres), 2));
            }
        },
        error: function (jqXHR, exception) {

            var msg = '';
            if (jqXHR.status === 0) {
                msg = 'Not connect.\n Verify Network.';
            } else if (jqXHR.status === 404) {
                msg = 'Requested page not found. [404]';
            } else if (jqXHR.status === 500) {
                msg = 'Internal Server Error [500].';
            } else if (exception === 'parsererror') {
                msg = 'Requested JSON parse failed.';
            } else if (exception === 'timeout') {
                msg = 'Time out error.';
            } else if (exception === 'abort') {
                msg = 'Ajax request aborted.';
            } else {
                msg = 'Uncaught Error.\n' + jqXHR.responseText;
            }
            $("#error_ModalLabel").html("Warning !!!");
            $("#error_modalText").html(msg);

            $("#errorModal").modal("show");
        }
    });
}