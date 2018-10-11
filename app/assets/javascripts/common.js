$(document).on("click",".close-alert",function() {
  $(".alert").hide();
});

$(function() {
  $('#itemsTable').DataTable();
  $('#billsTable').DataTable();
  $('.tags').tagsInput({
    'defaultText':'Add a tag'
  });
})



$(document).on("click", ".button-remove", function() {
  $(this).closest(".box").remove();
});
$(document).on("click", ".add_item", function() {
  var obj = $('.bill_item:first').clone().insertAfter(".bill_item:last");
  obj.find(".item_amount").text("0.00");
  obj.find(".amount").text("0.00");
  obj.find(".form-control").val("");
  obj.find(".remove").html("<a href='javascript:void(0)' class='remove_item'>x</a>");
});
$(document).on("click", ".remove_item", function() {
  $(this).closest(".bill_item").remove();
  calculateTotalAmount();
});
$(document).on("click", function() {
  
  $('.float_only').keypress(function(event) {
    if ((event.which != 46 || $(this).val().indexOf('.') != -1) && (event.which < 48 || event.which > 57)) {
      event.preventDefault();
    }
  });

  $(".numbers_only").keydown(function (e) {
    if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 110]) !== -1 || (e.keyCode === 65 && (e.ctrlKey === true || e.metaKey === true)) || (e.keyCode >= 35 && e.keyCode <= 40)) {
        return;
    }
    if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
      e.preventDefault();
    }
  });

  $(".select_item").on('change', function(){
    var price = $(this).find(":selected").data("price");
    if($.type(price) === "undefined"){
      price = "0.0";
    }
    var quantity = $(this).closest(".bill_item").find(".item_qty").val();
    if(quantity == ""){
      quantity = 0;
    }
    quantity = parseInt(quantity);
    price = parseFloat(price).toFixed(2);
    // console.log(price);
    $(this).closest(".bill_item").find(".item_amount").text(price);
    total_amount = (price * quantity).toFixed(2)
    $(this).closest(".bill_item").find(".amount").text(total_amount);
    calculateTotalAmount();
  })

  $(".item_qty").keyup(function (e) {
    var quantity = $(this).val();
    if(quantity == ""){
      quantity = 0;
    }
    var price = $(this).closest(".bill_item").find(".item_amount").text();
    quantity = parseInt(quantity);
    price = parseFloat(price).toFixed(2);
    total_amount = (price * quantity).toFixed(2)
    $(this).closest(".bill_item").find(".amount").text(total_amount);
    calculateTotalAmount();
  });

  function calculateTotalAmount(){
    var total_amount = 0;
    var net_amount = 0;
    $(".bill_item").each(function( index ) {
      var price = parseFloat( $(this).find(".item_amount").text() );
      var quantity = $(this).find(".item_qty").val();
      if(quantity == ""){
        quantity = 0;
      }
      parseInt( quantity );
      total_amount = total_amount + (price * quantity);
    });
    net_amount = total_amount + (total_amount * 0.15);
    $(".total_amount").text(total_amount.toFixed(2));
    $(".net_amount").text(net_amount.toFixed(2));
  }
  
});
