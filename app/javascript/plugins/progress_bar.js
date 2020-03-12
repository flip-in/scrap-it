
const progressBar = () => {
  $(".reward-container-progress").each(function(){
    
    var $total_points = $(this).find(".d-none");
    var $total_points_int = parseInt($total_points.text(), 10)
    var $bar = $(this).find(".bar");
    var $user_points = $(this).find(".bar-points");
    var $user_points_int = parseInt( $user_points.text(), 10);
    var perc = ($user_points_int / $total_points_int) * 100
    console.log(perc)

    $({p:0}).animate({p:perc}, {
      duration: 3000,
      easing: "swing",
      step: function(p) {
        $bar.css({
          transform: "rotate("+ (45+(p*1.8)) +"deg)", // 100%=180° so: ° = % * 1.8
          // 45 is to add the needed rotation to have the green borders at the bottom
        });
        $user_points.text(p|0);
      }
    });
  });
}  

export {progressBar};