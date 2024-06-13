DROP PROCEDURE IF EXISTS calculate_and_insert_summary;

DELIMITER //

CREATE PROCEDURE calculate_and_insert_summary(IN p_updatedCutoff DATETIME)
BEGIN
    -- Declare variables to store loop values and calculated amount
    DECLARE done INT DEFAULT FALSE;
    DECLARE _user_id BIGINT(20);
    DECLARE _coin_id BIGINT(20);
    DECLARE _final_amount DECIMAL(23,8);
    DECLARE _plus_amount DECIMAL(23,8);
    DECLARE _minus_amount DECIMAL(23,8);
    DECLARE _cutoff DATETIME DEFAULT p_updatedCutoff;

    -- Declare the cursor for the user_ids and coin_ids

    DECLARE cur1 CURSOR FOR SELECT DISTINCT user_id, coin_id FROM user_ledger WHERE created_at < _cutoff;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Open the cursor
    OPEN cur1;

    read_loop: LOOP
        FETCH cur1 INTO _user_id, _coin_id;

        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Calculate the sum of 'plus' activities, now including activity '70'
        SELECT COALESCE(SUM(amount), 0) INTO _plus_amount
        FROM user_ledger
        WHERE user_id = _user_id AND coin_id = _coin_id AND activity IN (0,1,2,8,12,13,14,20,22,25,29,30,31,32,33,34,41,42,53,55,56,62,63,49,53,60,64,65,66,68,70) AND created_at < _cutoff;

        -- Calculate the sum of 'minus' activities
        SELECT COALESCE(SUM(amount), 0) INTO _minus_amount
        FROM user_ledger
        WHERE user_id = _user_id AND coin_id = _coin_id AND activity IN (6,15,16,17,18,19,21,28,45,48,51,52,54,58,50,54,58,59,61,67,69) AND created_at < _cutoff;

        -- Calculate the final amount
        SET _final_amount = _plus_amount - _minus_amount;

        DELETE FROM user_ledger  WHERE user_id = _user_id AND coin_id = _coin_id AND activity IN (0,1,2,8,12,13,14,20,22,25,29,30,31,32,33,34,41,42,53,55,56,62,63,49,53,60,64,65,66,68,6,15,16,17,18,19,21,28,45,48,51,52,54,58,50,54,58,59,61,67,69,70) AND created_at < _cutoff;
        -- Insert the new record with calculated amount. Using '70' as activity as per requirement.
        INSERT INTO user_ledger (user_id, coin_id, amount, activity, created_at, updated_at)
        VALUES (_user_id, _coin_id, _final_amount, 70, _cutoff, _cutoff);

    END LOOP;

    -- Close the cursor
    CLOSE cur1;

END;

DELIMITER ;





-- To execute the procedure
CALL calculate_and_insert_summary('2023-06-01 00:00:00');