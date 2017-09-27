set fp [open patternsRom.mif w]

for {set i 0} {$i < 100} {incr i} {

        #puts $fp "0000000000000001"
        set res {}
        set ii [expr $i * $i]
        set width 16
        set d {}

        while {$ii>0} {

            set res [expr {$ii%2}]$res
            set ii [expr {$ii/2}]
        }
        if {$res == {}} {set res 0}

        if {$width ne {}} {

            append d [string repeat 0 $width] $res
            set res [string range $d [string length $res] end]
        }
        puts $fp $res
}

close $fp
