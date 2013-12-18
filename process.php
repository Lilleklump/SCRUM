<?php
include('assets/class.php');

$function = $_GET['function'];

if($function == "Login")
{
	if(empty($_POST['username']) OR empty($_POST['password']))
	{
		$Error->set("Fyll i alla fällt.");
		header('location: /login.php');
	}
	else
	{
		$username = mysql_real_escape_string($_POST['username']);
		$password = mysql_real_escape_string($_POST['password']);

		$query = mysql_query("SELECT * FROM tbl_user WHERE user_username = '$username' AND user_password = '$password'");
		$count = mysql_num_rows($query);

		if($count == 1)
		{
			$result = mysql_query("SELECT * FROM tbl_user WHERE user_username = '$username' LIMIT 1");
			$row = mysql_fetch_assoc($result);

			$date = date('Y-m-d H:i:s');
			$sql = "UPDATE tbl_user SET user_lastlogin = '".$date."' WHERE user_id = ".$row['user_id'];
			$result = mysql_query($sql);

			$_SESSION['username'] = $username;
			$_SESSION['user_id'] = $row['user_id'];
			$_SESSION['user_firstname'] = $row['user_firstname'];
			$_SESSION['user_lastname'] = $row['user_lastname'];
			$_SESSION['user_program'] = $row['user_program'];
			$_SESSION['usertype_id'] = $row['usertype_id'];
			header('location: index.php');
		}
		else
		{
			$Error->set("Fel användarnamn eller lösenord.");
			header("Location: /login.php");
		}
	}
}
elseif($function == "Register")
{
	if(@$_POST['agreement'] != "agree")
	{
		$Error->set("Du måste acceptera reglerna.");
		header("Location: /register.php");
	}
	else
	{
		if(empty($_POST['username']) OR empty($_POST['password']) OR empty($_POST['password2']) OR empty($_POST['email']) OR empty($_POST['email2']) OR empty($_POST['phone']) OR empty($_POST['fname']) OR empty($_POST['lname']) OR empty($_POST['school']))
		{
			$Error->set("Vänligen fyll i alla fält.");
			header("Location: /register.php");
		}
		else
		{
			if($Check->username($_POST['username']) == 1)
			{
				$Error->set("Användarnamnet finns redan i vårt system.");
				header("Location: /register.php");
			}
			else
			{
				if($Check->email($_POST['email']) == 1)
				{
					$Error->set("E-posten finns redan i vårt system.");
					header("Location: /register.php");
				}
				else
				{
					if($Check->length($_POST['username']) < 4)
					{
						$Error->set("Användarnamnet måste vara längre än 4 tecken.");
						header("Location: /register.php");
					}
					else
					{
						if($Check->length($_POST['password']) < 6)
						{
							$Error->set("Lösenordet måste vara längre än 6 tecken.");
							header("Location: /register.php");
						}
						else
						{
							if($_POST['password'] != $_POST['password2'])
							{
								$Error->set("Lösenorden matchande inte.");
								header("Location: /register.php");
							}
							else
							{
								if($_POST['email'] != $_POST['email2'])
								{
									$Error->set("E-posterna matchande inte varandra.");
									header("Location: /register.php");
								}
								else
								{
									if(!is_numeric($_POST['phone']))
									{
										$Error->set("Ett telefonnummer har väl bara nummer i sig?");
										header("Location: /register.php");
									}
									else
									{
										$username = mysql_real_escape_string($_POST['username']);
										$password = md5($_POST['password']);
										$email = mysql_real_escape_string($_POST['email']);
										$phone = mysql_real_escape_string($_POST['phone']);
										$fname = mysql_real_escape_string($_POST['fname']);
										$lname = mysql_real_escape_string($_POST['lname']);
										$school = mysql_real_escape_string($_POST['school']);

										$sql = "INSERT INTO users(username, fname, lname, password, email, phone, school)VALUES('".$username."', '".$fname."', '".$lname."', '".$password."', '".$email."', '".$phone."', '".$school."')";
										$add = mysql_query($sql);

										if($add){
											$Success->set("Grattis, du är nu medlem på ITGLan.se!");
											header('location: register.php');
										}
									}
								}
							}
						}
					}
				}
			}
		}
	}
}
else
{
	header('location: /index.php');
}
?>