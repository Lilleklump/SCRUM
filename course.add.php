<?php include("assets/_header.php"); ?>
<a href="course.php"><span class="label label-default">Tillbaka</span></a>
<?php
$user_id = mysql_real_escape_string($_GET['user_id']);
$user_result = mysql_query("SELECT * FROM tbl_user WHERE user_id='".$user_id."' LIMIT 1");
$user_row = mysql_fetch_assoc($user_result);
?>
<h3><?php echo $user_row['user_firstname']." ".$user_row['user_lastname'] ?></h3>
<form method="POST" action="./process.php?function=addGrade">
  <?php
  $Error->show();
  $Success->show();
  ?>
  <div class="radio">
    <label><input type="radio" name="grade" id="grade" value="IG">IG</label>
  </div>
  <div class="radio">
    <label><input type="radio" name="grade" id="grade" value="G">G</label>
  </div>
  <div class="radio">
    <label><input type="radio" name="grade" id="grade" value="VG">VG</label>
  </div>
  <br>
  <input type="text" name="grade_comment" class="form-control" placeholder="Kommentar">
  <br>
  <button class="btn btn-lg btn-primary" type="submit">Ge betyg</button>
</form>
<?php include("assets/_footer.php"); ?>
