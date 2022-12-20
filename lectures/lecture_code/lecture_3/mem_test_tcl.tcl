set m_path [lindex [get_service_paths master] 0]
open_service master $m_path
master_write_32 $m_path 0x0 0x01234567
master_write_32 $m_path 0x4 0x89abcdef
master_write_32 $m_path 0x8 0xaaaaaaaa
master_write_32 $m_path 0xc 0x55555555
puts [master_read_32 $m_path 0x0 0x4]
close_service master $m_path