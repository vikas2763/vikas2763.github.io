<?php


/*
==============simple chat===============

senderId     ----> integer
receiverID   ----> integer
message      ----> string

================Group chat==============

senderId 	---->integer
receiverId  ---->array(integer)
groupid		---->integer
message     ---->string


*/




class setvaribles
{
	public $mess=array();
	public $flag=array();
	public $val=array();
	public $chat_id;
	public $creategroup;
	public $conn;
	public $senderID;
	public $receiverID;
	public $message;
	public $isread;
	public $file_type;
	public $file;
	public $receiverID2='';
	public$len=0;
	public $i=0;
	public $count=0;
}



class instamelodyChat extends setvaribles
{

	public function __construct()
	{

	 define('DB_USERNAME', 'root');
	 define('DB_PASSWORD', 'amol1234');
	 define('DB_HOST', 'localhost');
	 define('DB_NAME', 'masenger');
	 $this->conn = new mysqli(DB_HOST,DB_USERNAME, DB_PASSWORD,DB_NAME);

	}

	public function setvalue($senderID,$receiverID)
		{
			$this->senderID=$senderID;
			$this->receiverID=$receiverID;
	 
			 
			$val=$this->validateUsers();
			if($val==='Validvalues')
			{
				return '200';
			}
		}



		  public function validateUsers()
		   {
			   $mess=array();
			   $mess['flag']='failed';
			 if(empty($this->senderID))
			    {
  					 $mess['error_message']='Oops sender is missing!';
   					 echo json_encode($mess);
   					 exit();
 			    }
	 		 else if(empty($this->receiverID))
	 		  {
	   		       $mess['error_message']='Oops receiver is missing!';
				   echo json_encode($mess);
				   exit();
				  }

              else if($this->senderID==$this->receiverID)
              {
				   $mess['error_message']='sender id and receiver id should not be same';
				   echo json_encode($mess);
				   exit();
              }else{

              	return 'Validvalues';
              }
		}


	 function createGroup($groupname,$group_pick)// create new group 
	   {
	   	
	   		$usersid=explode(',', $this->receiverID);
	   		array_push($usersid, $this->senderID);

	   		if(empty($group_pick))
	   		{
	   			$group_pick='default_pick';
	   		}
	   		if(empty($groupname))
	   		{
	   			$groupname='new group';
	   		}
	   		else
	   		{
		   	  if(is_string($name))
		   	  {
		   	  	$sql="INSERT INTO group (name,group_pick,is_active) VOLUES ('$groupname','$group_pick',1)";
		   		$num=$this->conn->query($sql) or die($this->conn->error);
		   		$last_id = $this->conn->insert_id;

		   		foreach ($usersid as $id) 
		   		{	   			
    	   		 $sql="INSERT INTO group_users (group_id,user_id,is_active) VOLUES ('$last_id','$id',1)";
		   		 $num=$this->conn->query($sql) or die($this->conn->error);
		   		}

		   	  }
		   	}
		   	 $responce=array('groupId'=>$last_id,'GroupName'=>$groupname,'groupPick'=>$group_pick);
		   	 $data=array('flag'=>'success','status'=>200,'response'=>$responce);
		   	 return json_encode($data);
		   				
		}	
 



	 	public function Groupchat($groupId,$chattype,$message)
	 	{

 	 		$chatid=$groupId;
	 		$rid=extract(',',$this->receiverID);
	 	 

	 		 # 1---insert into message table

	 			$SQL= "INSERT INTO message(creator_id,subject,message_body)
   	        	VALUES ('$this->senderID','$chattype','$message')";
   	        	$res= $conn->query($SQL) or die($conn->error);
   	        	$last_id = $this->conn->insert_id;

	 		 # 2---insert into message_recpient table for each recipient

	 	foreach ($rid as $key) 
	 		{

	 	  $SQL= "INSERT INTO message_recipient(recipient_id,senderId,recipient_group_id,messageID,isRead)
   	        	VALUES ('$key','$this->senderID','$groupId',$last_id',0)";
		       $res= $conn->query($SQL) or die($conn->error);
	 		}
		}



		public function SingleChat($chattype,$message,$senderID,$receiverID)
		{

			$SQL= "INSERT INTO message(creator_id,subject,message_body)
   	        	   VALUES ('$senderID','$chattype','$message')";
   	        	$res= $conn->query($SQL) or die($conn->error);
   	        	$last_id = $this->conn->insert_id;

   	        	$SQL= "INSERT INTO message_recipient(recipient_id,senderId,messageID,isRead)
   	        				VALUES ('$receiverID','$senderID',$last_id',0)";
		       $res= $conn->query($SQL) or die($conn->error);
		}


/*	
		privarte function ShareFiles(){
			
		}

		privarte function SendMessage(){

			# send notification to receivers according to there device
			but if sender is blocked by Admin or Receiver , he will not able to send message. 
		
		}
*/
		
}





extract($_POST);

if($chattype='single') # For single chat 
{
		  $single= new instamelodyChat;
		  $single->SingleChat($chattype,$message,$senderID,$receiverID);
}


if($chattype='group')  # @for group chat
{
	$multiple= new instamelodyChat;
	
# @set values for users and group in global variable

	$res=$multiple->setvalue($senderID,$receiverID);

# @On success we will go further for create Group


if($res===200)
{
	# @Create new group

	if( (trim($creategroup) === 'creatgroup') and empty($groupId))
	{
			$obj->createGroup($groupname);
	}

	# @Chat with existing Group with group unique id

	if(!empty($groupId) and ($chattype='group'))
	{
		  $obj->Groupchat($groupId,$chattype,$message);
	}
}

}





/*
creategroup
groupId
groupname
chattype
message
senderID
receiverID
Atachment => Doc,mediaFile, 

*/