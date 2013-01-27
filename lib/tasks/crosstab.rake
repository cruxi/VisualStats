require File.join(Rails.configuration.root,"lib/tasks/travismigrate")
include TravisMigrate

namespace :db do
  desc "Example for working with crosstab"
  task crosstab: :environment do
    do_crosstab
  end
end

def do_crosstab

q = <<DELIM

CREATE TEMPORARY TABLE build_result (result INT);
INSERT INTO build_result VALUES (0),(1);

SELECT * FROM crosstab(
'select concat(extract (year from finished_at) ,to_char(extract (month from finished_at),''00'') )
as year_month, result, count(*)
FROM visual_builds
GROUP BY year_month, result
ORDER BY year_month, result',
'SELECT * from build_result'
) AS (
 year_month text,
 success int, failed int
 ) ORDER BY year_month;
DELIM

  c = VisualBuild.connection
  res = c.execute(q)
  res.each do | tuple|
    puts tuple.inspect
  end
end


