function getval(sel)
{
    if(sel.value === 'BUFFALO'){
        $('#base_snf').html('9.0');
        $('#base_fat').html('6.0');
    }else if(sel.value === 'COW'){
        $('#base_snf').html('8.5');
        $('#base_fat').html('3.5');
    }
}

$(document).ready(function() {
    $('#rate_chart_table').DataTable({
        scrollY: 400,
        responsive: true
    });

    $('form#rate_chart_form').validate();
} );