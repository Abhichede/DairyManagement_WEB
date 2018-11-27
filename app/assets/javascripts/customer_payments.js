$(function () {
   $('#date_customer_payment').datetimepicker({
       format: 'DD-MM-YYYY',
       icons: {
           time: "fa fa-clock-o",
           date: "fa fa-calendar",
           up: "fa fa-arrow-up",
           down: "fa fa-arrow-down",
           previous: "fa fa-arrow-left",
           next: "fa fa-arrow-right"
       }
   });

   $('table#table_customer_payments').DataTable();
});