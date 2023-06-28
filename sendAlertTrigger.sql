DELIMITER $$
CREATE TRIGGER taskReminderTrigger
AFTER INSERT ON todoitem
FOR EACH ROW
BEGIN
    DECLARE reminder TIMESTAMP;
    DECLARE name VARCHAR(255);
    DECLARE listId INT;
    Declare isCompleted VARCHAR(255);

    -- Get the reminder date, task name, and list ID for the new task
	SELECT NEW.reminder, NEW.name, NEW.listId, NEW.isCompleted INTO reminder , name , listId, isCompleted;
    
    -- Calculate the date one day from now
    SET @one_day_from_now = CURDATE() + INTERVAL 1 DAY;
    
    -- Check if the reminder date is one day away and the task is not complete
    IF reminder = @one_day_from_now AND isCompleted = 'F' THEN
      SET @userByListId = (SELECT u.idUser FROM todolist l INNER JOIN user u ON l.userId=u.iduser WHERE l.idList = 2);
      INSERT INTO alerts (alertMessage, alertDate, userId) VALUES (CONCAT('Task "', "ff", '" is due tomorrow and is not complete.'), CURDATE(), @userByListId);
    END IF;
END$$
DELIMITER ;