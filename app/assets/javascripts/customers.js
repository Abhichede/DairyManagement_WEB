$(function () {
    $('form#new_customer_form').validate();
    $('#customer_milk_collection').DataTable({
        responsive: true
    });
    $('#customer_payment_history').DataTable({
        responsive: true
    });
    $('#customers_table').DataTable({
        responsive: true
    });
});