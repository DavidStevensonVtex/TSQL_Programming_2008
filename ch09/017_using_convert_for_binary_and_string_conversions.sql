-- Use style argument of CONVERT function
SELECT
  CONVERT(VARCHAR(20), 0x4775696E6E657373, 1) AS bin_to_prefixed_char,
  CONVERT(VARCHAR(20), 0x4775696E6E657373, 2) AS bin_to_nonprefixed_char;
--bin_to_prefixed_char bin_to_nonprefixed_char
---------------------- -----------------------
--0x4775696E6E657373   4775696E6E657373

SELECT
  CONVERT(VARBINARY(10), '0x4775696E6E657373', 1) AS prefixed_char_to_bin,
  CONVERT(VARBINARY(10),   '4775696E6E657373', 2) AS nonprefixed_char_to_bin;
--prefixed_char_to_bin   nonprefixed_char_to_bin
------------------------ -----------------------
--0x4775696E6E657373     0x4775696E6E657373

-- https://learn.microsoft.com/en-us/sql/t-sql/functions/cast-and-convert-transact-sql?view=sql-server-ver16&redirectedfrom=MSDN