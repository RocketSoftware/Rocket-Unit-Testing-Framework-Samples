       program-id. GetFlyerLevel.
       linkage section.
       copy "GetFlyerLevel.cpy" replacing ==:prefix:== by ==lnk==.
       01 lnk-extra-status-points  td-flyer-status-points.
       procedure division using lnk-flyer-info, lnk-extra-status-points.
           add lnk-extra-status-points to lnk-award-points
           
           evaluate lnk-award-points
                when < 300
                   move "Bronze" to lnk-award-level
                when >= 300 and < 700
                   move "Silver" to lnk-award-level
                when >= 700 and < 1500
                   move "Gold" to lnk-award-level
                when >= 1500 and < 10000
                  move "Platinum" to lnk-award-level
               when other
                   move "Diamond" to lnk-award-level
           end-evaluate
       end program.
