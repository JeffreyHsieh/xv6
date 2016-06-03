
_h2o:     file format elf32-i386


Disassembly of section .text:

00001000 <init_qs>:
    1000:	55                   	push   %ebp
    1001:	89 e5                	mov    %esp,%ebp
    1003:	8b 45 08             	mov    0x8(%ebp),%eax
    1006:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    100c:	8b 45 08             	mov    0x8(%ebp),%eax
    100f:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    1016:	8b 45 08             	mov    0x8(%ebp),%eax
    1019:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
    1020:	5d                   	pop    %ebp
    1021:	c3                   	ret    

00001022 <add_qs>:
    1022:	55                   	push   %ebp
    1023:	89 e5                	mov    %esp,%ebp
    1025:	83 ec 28             	sub    $0x28,%esp
    1028:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    102f:	e8 8f 12 00 00       	call   22c3 <malloc>
    1034:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1037:	8b 45 f4             	mov    -0xc(%ebp),%eax
    103a:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    1041:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1044:	8b 55 0c             	mov    0xc(%ebp),%edx
    1047:	89 10                	mov    %edx,(%eax)
    1049:	8b 45 08             	mov    0x8(%ebp),%eax
    104c:	8b 40 04             	mov    0x4(%eax),%eax
    104f:	85 c0                	test   %eax,%eax
    1051:	75 0b                	jne    105e <add_qs+0x3c>
    1053:	8b 45 08             	mov    0x8(%ebp),%eax
    1056:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1059:	89 50 04             	mov    %edx,0x4(%eax)
    105c:	eb 0c                	jmp    106a <add_qs+0x48>
    105e:	8b 45 08             	mov    0x8(%ebp),%eax
    1061:	8b 40 08             	mov    0x8(%eax),%eax
    1064:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1067:	89 50 04             	mov    %edx,0x4(%eax)
    106a:	8b 45 08             	mov    0x8(%ebp),%eax
    106d:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1070:	89 50 08             	mov    %edx,0x8(%eax)
    1073:	8b 45 08             	mov    0x8(%ebp),%eax
    1076:	8b 00                	mov    (%eax),%eax
    1078:	8d 50 01             	lea    0x1(%eax),%edx
    107b:	8b 45 08             	mov    0x8(%ebp),%eax
    107e:	89 10                	mov    %edx,(%eax)
    1080:	c9                   	leave  
    1081:	c3                   	ret    

00001082 <empty_qs>:
    1082:	55                   	push   %ebp
    1083:	89 e5                	mov    %esp,%ebp
    1085:	8b 45 08             	mov    0x8(%ebp),%eax
    1088:	8b 00                	mov    (%eax),%eax
    108a:	85 c0                	test   %eax,%eax
    108c:	75 07                	jne    1095 <empty_qs+0x13>
    108e:	b8 01 00 00 00       	mov    $0x1,%eax
    1093:	eb 05                	jmp    109a <empty_qs+0x18>
    1095:	b8 00 00 00 00       	mov    $0x0,%eax
    109a:	5d                   	pop    %ebp
    109b:	c3                   	ret    

0000109c <pop_qs>:
    109c:	55                   	push   %ebp
    109d:	89 e5                	mov    %esp,%ebp
    109f:	83 ec 28             	sub    $0x28,%esp
    10a2:	8b 45 08             	mov    0x8(%ebp),%eax
    10a5:	89 04 24             	mov    %eax,(%esp)
    10a8:	e8 d5 ff ff ff       	call   1082 <empty_qs>
    10ad:	85 c0                	test   %eax,%eax
    10af:	75 5d                	jne    110e <pop_qs+0x72>
    10b1:	8b 45 08             	mov    0x8(%ebp),%eax
    10b4:	8b 40 04             	mov    0x4(%eax),%eax
    10b7:	8b 00                	mov    (%eax),%eax
    10b9:	89 45 f0             	mov    %eax,-0x10(%ebp)
    10bc:	8b 45 08             	mov    0x8(%ebp),%eax
    10bf:	8b 40 04             	mov    0x4(%eax),%eax
    10c2:	89 45 f4             	mov    %eax,-0xc(%ebp)
    10c5:	8b 45 08             	mov    0x8(%ebp),%eax
    10c8:	8b 40 04             	mov    0x4(%eax),%eax
    10cb:	8b 50 04             	mov    0x4(%eax),%edx
    10ce:	8b 45 08             	mov    0x8(%ebp),%eax
    10d1:	89 50 04             	mov    %edx,0x4(%eax)
    10d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    10d7:	89 04 24             	mov    %eax,(%esp)
    10da:	e8 b5 10 00 00       	call   2194 <free>
    10df:	8b 45 08             	mov    0x8(%ebp),%eax
    10e2:	8b 00                	mov    (%eax),%eax
    10e4:	8d 50 ff             	lea    -0x1(%eax),%edx
    10e7:	8b 45 08             	mov    0x8(%ebp),%eax
    10ea:	89 10                	mov    %edx,(%eax)
    10ec:	8b 45 08             	mov    0x8(%ebp),%eax
    10ef:	8b 00                	mov    (%eax),%eax
    10f1:	85 c0                	test   %eax,%eax
    10f3:	75 14                	jne    1109 <pop_qs+0x6d>
    10f5:	8b 45 08             	mov    0x8(%ebp),%eax
    10f8:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    10ff:	8b 45 08             	mov    0x8(%ebp),%eax
    1102:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
    1109:	8b 45 f0             	mov    -0x10(%ebp),%eax
    110c:	eb 05                	jmp    1113 <pop_qs+0x77>
    110e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1113:	c9                   	leave  
    1114:	c3                   	ret    

00001115 <sem_init>:
    1115:	55                   	push   %ebp
    1116:	89 e5                	mov    %esp,%ebp
    1118:	83 ec 18             	sub    $0x18,%esp
    111b:	8b 45 08             	mov    0x8(%ebp),%eax
    111e:	8b 55 0c             	mov    0xc(%ebp),%edx
    1121:	89 10                	mov    %edx,(%eax)
    1123:	8b 45 08             	mov    0x8(%ebp),%eax
    1126:	8b 55 0c             	mov    0xc(%ebp),%edx
    1129:	89 50 04             	mov    %edx,0x4(%eax)
    112c:	8b 45 08             	mov    0x8(%ebp),%eax
    112f:	83 c0 0c             	add    $0xc,%eax
    1132:	89 04 24             	mov    %eax,(%esp)
    1135:	e8 c6 fe ff ff       	call   1000 <init_qs>
    113a:	8b 45 08             	mov    0x8(%ebp),%eax
    113d:	83 c0 08             	add    $0x8,%eax
    1140:	89 04 24             	mov    %eax,(%esp)
    1143:	e8 76 12 00 00       	call   23be <lock_init>
    1148:	c9                   	leave  
    1149:	c3                   	ret    

0000114a <sem_acquire>:
    114a:	55                   	push   %ebp
    114b:	89 e5                	mov    %esp,%ebp
    114d:	83 ec 18             	sub    $0x18,%esp
    1150:	8b 45 08             	mov    0x8(%ebp),%eax
    1153:	8b 00                	mov    (%eax),%eax
    1155:	85 c0                	test   %eax,%eax
    1157:	7e 2b                	jle    1184 <sem_acquire+0x3a>
    1159:	8b 45 08             	mov    0x8(%ebp),%eax
    115c:	83 c0 08             	add    $0x8,%eax
    115f:	89 04 24             	mov    %eax,(%esp)
    1162:	e8 65 12 00 00       	call   23cc <lock_acquire>
    1167:	8b 45 08             	mov    0x8(%ebp),%eax
    116a:	8b 00                	mov    (%eax),%eax
    116c:	8d 50 ff             	lea    -0x1(%eax),%edx
    116f:	8b 45 08             	mov    0x8(%ebp),%eax
    1172:	89 10                	mov    %edx,(%eax)
    1174:	8b 45 08             	mov    0x8(%ebp),%eax
    1177:	83 c0 08             	add    $0x8,%eax
    117a:	89 04 24             	mov    %eax,(%esp)
    117d:	e8 69 12 00 00       	call   23eb <lock_release>
    1182:	eb 43                	jmp    11c7 <sem_acquire+0x7d>
    1184:	8b 45 08             	mov    0x8(%ebp),%eax
    1187:	83 c0 08             	add    $0x8,%eax
    118a:	89 04 24             	mov    %eax,(%esp)
    118d:	e8 3a 12 00 00       	call   23cc <lock_acquire>
    1192:	e8 25 0d 00 00       	call   1ebc <getpid>
    1197:	8b 55 08             	mov    0x8(%ebp),%edx
    119a:	83 c2 0c             	add    $0xc,%edx
    119d:	89 44 24 04          	mov    %eax,0x4(%esp)
    11a1:	89 14 24             	mov    %edx,(%esp)
    11a4:	e8 79 fe ff ff       	call   1022 <add_qs>
    11a9:	8b 45 08             	mov    0x8(%ebp),%eax
    11ac:	83 c0 08             	add    $0x8,%eax
    11af:	89 04 24             	mov    %eax,(%esp)
    11b2:	e8 34 12 00 00       	call   23eb <lock_release>
    11b7:	e8 30 0d 00 00       	call   1eec <tsleep>
    11bc:	8b 45 08             	mov    0x8(%ebp),%eax
    11bf:	89 04 24             	mov    %eax,(%esp)
    11c2:	e8 83 ff ff ff       	call   114a <sem_acquire>
    11c7:	c9                   	leave  
    11c8:	c3                   	ret    

000011c9 <sem_signal>:
    11c9:	55                   	push   %ebp
    11ca:	89 e5                	mov    %esp,%ebp
    11cc:	83 ec 18             	sub    $0x18,%esp
    11cf:	8b 45 08             	mov    0x8(%ebp),%eax
    11d2:	8b 10                	mov    (%eax),%edx
    11d4:	8b 45 08             	mov    0x8(%ebp),%eax
    11d7:	8b 40 04             	mov    0x4(%eax),%eax
    11da:	39 c2                	cmp    %eax,%edx
    11dc:	7d 51                	jge    122f <sem_signal+0x66>
    11de:	8b 45 08             	mov    0x8(%ebp),%eax
    11e1:	83 c0 08             	add    $0x8,%eax
    11e4:	89 04 24             	mov    %eax,(%esp)
    11e7:	e8 e0 11 00 00       	call   23cc <lock_acquire>
    11ec:	8b 45 08             	mov    0x8(%ebp),%eax
    11ef:	8b 00                	mov    (%eax),%eax
    11f1:	8d 50 01             	lea    0x1(%eax),%edx
    11f4:	8b 45 08             	mov    0x8(%ebp),%eax
    11f7:	89 10                	mov    %edx,(%eax)
    11f9:	8b 45 08             	mov    0x8(%ebp),%eax
    11fc:	83 c0 08             	add    $0x8,%eax
    11ff:	89 04 24             	mov    %eax,(%esp)
    1202:	e8 e4 11 00 00       	call   23eb <lock_release>
    1207:	8b 45 08             	mov    0x8(%ebp),%eax
    120a:	83 c0 0c             	add    $0xc,%eax
    120d:	89 04 24             	mov    %eax,(%esp)
    1210:	e8 6d fe ff ff       	call   1082 <empty_qs>
    1215:	85 c0                	test   %eax,%eax
    1217:	75 16                	jne    122f <sem_signal+0x66>
    1219:	8b 45 08             	mov    0x8(%ebp),%eax
    121c:	83 c0 0c             	add    $0xc,%eax
    121f:	89 04 24             	mov    %eax,(%esp)
    1222:	e8 75 fe ff ff       	call   109c <pop_qs>
    1227:	89 04 24             	mov    %eax,(%esp)
    122a:	e8 c5 0c 00 00       	call   1ef4 <twakeup>
    122f:	c9                   	leave  
    1230:	c3                   	ret    

00001231 <main>:
    1231:	55                   	push   %ebp
    1232:	89 e5                	mov    %esp,%ebp
    1234:	83 e4 f0             	and    $0xfffffff0,%esp
    1237:	83 ec 10             	sub    $0x10,%esp
    123a:	c7 04 24 18 00 00 00 	movl   $0x18,(%esp)
    1241:	e8 7d 10 00 00       	call   22c3 <malloc>
    1246:	a3 c0 27 00 00       	mov    %eax,0x27c0
    124b:	c7 04 24 18 00 00 00 	movl   $0x18,(%esp)
    1252:	e8 6c 10 00 00       	call   22c3 <malloc>
    1257:	a3 c4 27 00 00       	mov    %eax,0x27c4
    125c:	c7 04 24 18 00 00 00 	movl   $0x18,(%esp)
    1263:	e8 5b 10 00 00       	call   22c3 <malloc>
    1268:	a3 c8 27 00 00       	mov    %eax,0x27c8
    126d:	a1 c8 27 00 00       	mov    0x27c8,%eax
    1272:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    1279:	00 
    127a:	89 04 24             	mov    %eax,(%esp)
    127d:	e8 93 fe ff ff       	call   1115 <sem_init>
    1282:	a1 c8 27 00 00       	mov    0x27c8,%eax
    1287:	89 04 24             	mov    %eax,(%esp)
    128a:	e8 bb fe ff ff       	call   114a <sem_acquire>
    128f:	c7 44 24 04 18 26 00 	movl   $0x2618,0x4(%esp)
    1296:	00 
    1297:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    129e:	e8 3a 0d 00 00       	call   1fdd <printf>
    12a3:	a1 c8 27 00 00       	mov    0x27c8,%eax
    12a8:	89 04 24             	mov    %eax,(%esp)
    12ab:	e8 19 ff ff ff       	call   11c9 <sem_signal>
    12b0:	a1 c0 27 00 00       	mov    0x27c0,%eax
    12b5:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    12bc:	00 
    12bd:	89 04 24             	mov    %eax,(%esp)
    12c0:	e8 50 fe ff ff       	call   1115 <sem_init>
    12c5:	a1 c4 27 00 00       	mov    0x27c4,%eax
    12ca:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    12d1:	00 
    12d2:	89 04 24             	mov    %eax,(%esp)
    12d5:	e8 3b fe ff ff       	call   1115 <sem_init>
    12da:	c7 05 d8 27 00 00 00 	movl   $0x0,0x27d8
    12e1:	00 00 00 
    12e4:	e9 7e 01 00 00       	jmp    1467 <main+0x236>
    12e9:	b8 76 1a 00 00       	mov    $0x1a76,%eax
    12ee:	c7 44 24 04 a4 27 00 	movl   $0x27a4,0x4(%esp)
    12f5:	00 
    12f6:	89 04 24             	mov    %eax,(%esp)
    12f9:	e8 08 11 00 00       	call   2406 <thread_create>
    12fe:	a3 e0 27 00 00       	mov    %eax,0x27e0
    1303:	a1 e0 27 00 00       	mov    0x27e0,%eax
    1308:	85 c0                	test   %eax,%eax
    130a:	75 33                	jne    133f <main+0x10e>
    130c:	a1 c8 27 00 00       	mov    0x27c8,%eax
    1311:	89 04 24             	mov    %eax,(%esp)
    1314:	e8 31 fe ff ff       	call   114a <sem_acquire>
    1319:	c7 44 24 04 59 26 00 	movl   $0x2659,0x4(%esp)
    1320:	00 
    1321:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1328:	e8 b0 0c 00 00       	call   1fdd <printf>
    132d:	a1 c8 27 00 00       	mov    0x27c8,%eax
    1332:	89 04 24             	mov    %eax,(%esp)
    1335:	e8 8f fe ff ff       	call   11c9 <sem_signal>
    133a:	e8 fd 0a 00 00       	call   1e3c <exit>
    133f:	c7 05 dc 27 00 00 00 	movl   $0x0,0x27dc
    1346:	00 00 00 
    1349:	eb 0d                	jmp    1358 <main+0x127>
    134b:	a1 dc 27 00 00       	mov    0x27dc,%eax
    1350:	83 c0 01             	add    $0x1,%eax
    1353:	a3 dc 27 00 00       	mov    %eax,0x27dc
    1358:	a1 dc 27 00 00       	mov    0x27dc,%eax
    135d:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    1362:	7e e7                	jle    134b <main+0x11a>
    1364:	b8 76 1a 00 00       	mov    $0x1a76,%eax
    1369:	c7 44 24 04 a4 27 00 	movl   $0x27a4,0x4(%esp)
    1370:	00 
    1371:	89 04 24             	mov    %eax,(%esp)
    1374:	e8 8d 10 00 00       	call   2406 <thread_create>
    1379:	a3 e0 27 00 00       	mov    %eax,0x27e0
    137e:	a1 e0 27 00 00       	mov    0x27e0,%eax
    1383:	85 c0                	test   %eax,%eax
    1385:	75 33                	jne    13ba <main+0x189>
    1387:	a1 c8 27 00 00       	mov    0x27c8,%eax
    138c:	89 04 24             	mov    %eax,(%esp)
    138f:	e8 b6 fd ff ff       	call   114a <sem_acquire>
    1394:	c7 44 24 04 59 26 00 	movl   $0x2659,0x4(%esp)
    139b:	00 
    139c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    13a3:	e8 35 0c 00 00       	call   1fdd <printf>
    13a8:	a1 c8 27 00 00       	mov    0x27c8,%eax
    13ad:	89 04 24             	mov    %eax,(%esp)
    13b0:	e8 14 fe ff ff       	call   11c9 <sem_signal>
    13b5:	e8 82 0a 00 00       	call   1e3c <exit>
    13ba:	c7 05 dc 27 00 00 00 	movl   $0x0,0x27dc
    13c1:	00 00 00 
    13c4:	eb 0d                	jmp    13d3 <main+0x1a2>
    13c6:	a1 dc 27 00 00       	mov    0x27dc,%eax
    13cb:	83 c0 01             	add    $0x1,%eax
    13ce:	a3 dc 27 00 00       	mov    %eax,0x27dc
    13d3:	a1 dc 27 00 00       	mov    0x27dc,%eax
    13d8:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    13dd:	7e e7                	jle    13c6 <main+0x195>
    13df:	b8 27 1b 00 00       	mov    $0x1b27,%eax
    13e4:	c7 44 24 04 a4 27 00 	movl   $0x27a4,0x4(%esp)
    13eb:	00 
    13ec:	89 04 24             	mov    %eax,(%esp)
    13ef:	e8 12 10 00 00       	call   2406 <thread_create>
    13f4:	a3 e0 27 00 00       	mov    %eax,0x27e0
    13f9:	a1 e0 27 00 00       	mov    0x27e0,%eax
    13fe:	85 c0                	test   %eax,%eax
    1400:	75 33                	jne    1435 <main+0x204>
    1402:	a1 c8 27 00 00       	mov    0x27c8,%eax
    1407:	89 04 24             	mov    %eax,(%esp)
    140a:	e8 3b fd ff ff       	call   114a <sem_acquire>
    140f:	c7 44 24 04 59 26 00 	movl   $0x2659,0x4(%esp)
    1416:	00 
    1417:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    141e:	e8 ba 0b 00 00       	call   1fdd <printf>
    1423:	a1 c8 27 00 00       	mov    0x27c8,%eax
    1428:	89 04 24             	mov    %eax,(%esp)
    142b:	e8 99 fd ff ff       	call   11c9 <sem_signal>
    1430:	e8 07 0a 00 00       	call   1e3c <exit>
    1435:	c7 05 dc 27 00 00 00 	movl   $0x0,0x27dc
    143c:	00 00 00 
    143f:	eb 0d                	jmp    144e <main+0x21d>
    1441:	a1 dc 27 00 00       	mov    0x27dc,%eax
    1446:	83 c0 01             	add    $0x1,%eax
    1449:	a3 dc 27 00 00       	mov    %eax,0x27dc
    144e:	a1 dc 27 00 00       	mov    0x27dc,%eax
    1453:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    1458:	7e e7                	jle    1441 <main+0x210>
    145a:	a1 d8 27 00 00       	mov    0x27d8,%eax
    145f:	83 c0 01             	add    $0x1,%eax
    1462:	a3 d8 27 00 00       	mov    %eax,0x27d8
    1467:	a1 d8 27 00 00       	mov    0x27d8,%eax
    146c:	85 c0                	test   %eax,%eax
    146e:	0f 8e 75 fe ff ff    	jle    12e9 <main+0xb8>
    1474:	e8 cb 09 00 00       	call   1e44 <wait>
    1479:	85 c0                	test   %eax,%eax
    147b:	79 f7                	jns    1474 <main+0x243>
    147d:	a1 c8 27 00 00       	mov    0x27c8,%eax
    1482:	89 04 24             	mov    %eax,(%esp)
    1485:	e8 c0 fc ff ff       	call   114a <sem_acquire>
    148a:	c7 44 24 04 74 26 00 	movl   $0x2674,0x4(%esp)
    1491:	00 
    1492:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1499:	e8 3f 0b 00 00       	call   1fdd <printf>
    149e:	a1 c8 27 00 00       	mov    0x27c8,%eax
    14a3:	89 04 24             	mov    %eax,(%esp)
    14a6:	e8 1e fd ff ff       	call   11c9 <sem_signal>
    14ab:	a1 c0 27 00 00       	mov    0x27c0,%eax
    14b0:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    14b7:	00 
    14b8:	89 04 24             	mov    %eax,(%esp)
    14bb:	e8 55 fc ff ff       	call   1115 <sem_init>
    14c0:	a1 c4 27 00 00       	mov    0x27c4,%eax
    14c5:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    14cc:	00 
    14cd:	89 04 24             	mov    %eax,(%esp)
    14d0:	e8 40 fc ff ff       	call   1115 <sem_init>
    14d5:	c7 05 d8 27 00 00 00 	movl   $0x0,0x27d8
    14dc:	00 00 00 
    14df:	e9 7e 01 00 00       	jmp    1662 <main+0x431>
    14e4:	b8 27 1b 00 00       	mov    $0x1b27,%eax
    14e9:	c7 44 24 04 a4 27 00 	movl   $0x27a4,0x4(%esp)
    14f0:	00 
    14f1:	89 04 24             	mov    %eax,(%esp)
    14f4:	e8 0d 0f 00 00       	call   2406 <thread_create>
    14f9:	a3 e0 27 00 00       	mov    %eax,0x27e0
    14fe:	a1 e0 27 00 00       	mov    0x27e0,%eax
    1503:	85 c0                	test   %eax,%eax
    1505:	75 33                	jne    153a <main+0x309>
    1507:	a1 c8 27 00 00       	mov    0x27c8,%eax
    150c:	89 04 24             	mov    %eax,(%esp)
    150f:	e8 36 fc ff ff       	call   114a <sem_acquire>
    1514:	c7 44 24 04 59 26 00 	movl   $0x2659,0x4(%esp)
    151b:	00 
    151c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1523:	e8 b5 0a 00 00       	call   1fdd <printf>
    1528:	a1 c8 27 00 00       	mov    0x27c8,%eax
    152d:	89 04 24             	mov    %eax,(%esp)
    1530:	e8 94 fc ff ff       	call   11c9 <sem_signal>
    1535:	e8 02 09 00 00       	call   1e3c <exit>
    153a:	c7 05 dc 27 00 00 00 	movl   $0x0,0x27dc
    1541:	00 00 00 
    1544:	eb 0d                	jmp    1553 <main+0x322>
    1546:	a1 dc 27 00 00       	mov    0x27dc,%eax
    154b:	83 c0 01             	add    $0x1,%eax
    154e:	a3 dc 27 00 00       	mov    %eax,0x27dc
    1553:	a1 dc 27 00 00       	mov    0x27dc,%eax
    1558:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    155d:	7e e7                	jle    1546 <main+0x315>
    155f:	b8 76 1a 00 00       	mov    $0x1a76,%eax
    1564:	c7 44 24 04 a4 27 00 	movl   $0x27a4,0x4(%esp)
    156b:	00 
    156c:	89 04 24             	mov    %eax,(%esp)
    156f:	e8 92 0e 00 00       	call   2406 <thread_create>
    1574:	a3 e0 27 00 00       	mov    %eax,0x27e0
    1579:	a1 e0 27 00 00       	mov    0x27e0,%eax
    157e:	85 c0                	test   %eax,%eax
    1580:	75 33                	jne    15b5 <main+0x384>
    1582:	a1 c8 27 00 00       	mov    0x27c8,%eax
    1587:	89 04 24             	mov    %eax,(%esp)
    158a:	e8 bb fb ff ff       	call   114a <sem_acquire>
    158f:	c7 44 24 04 59 26 00 	movl   $0x2659,0x4(%esp)
    1596:	00 
    1597:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    159e:	e8 3a 0a 00 00       	call   1fdd <printf>
    15a3:	a1 c8 27 00 00       	mov    0x27c8,%eax
    15a8:	89 04 24             	mov    %eax,(%esp)
    15ab:	e8 19 fc ff ff       	call   11c9 <sem_signal>
    15b0:	e8 87 08 00 00       	call   1e3c <exit>
    15b5:	c7 05 dc 27 00 00 00 	movl   $0x0,0x27dc
    15bc:	00 00 00 
    15bf:	eb 0d                	jmp    15ce <main+0x39d>
    15c1:	a1 dc 27 00 00       	mov    0x27dc,%eax
    15c6:	83 c0 01             	add    $0x1,%eax
    15c9:	a3 dc 27 00 00       	mov    %eax,0x27dc
    15ce:	a1 dc 27 00 00       	mov    0x27dc,%eax
    15d3:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    15d8:	7e e7                	jle    15c1 <main+0x390>
    15da:	b8 76 1a 00 00       	mov    $0x1a76,%eax
    15df:	c7 44 24 04 a4 27 00 	movl   $0x27a4,0x4(%esp)
    15e6:	00 
    15e7:	89 04 24             	mov    %eax,(%esp)
    15ea:	e8 17 0e 00 00       	call   2406 <thread_create>
    15ef:	a3 e0 27 00 00       	mov    %eax,0x27e0
    15f4:	a1 e0 27 00 00       	mov    0x27e0,%eax
    15f9:	85 c0                	test   %eax,%eax
    15fb:	75 33                	jne    1630 <main+0x3ff>
    15fd:	a1 c8 27 00 00       	mov    0x27c8,%eax
    1602:	89 04 24             	mov    %eax,(%esp)
    1605:	e8 40 fb ff ff       	call   114a <sem_acquire>
    160a:	c7 44 24 04 59 26 00 	movl   $0x2659,0x4(%esp)
    1611:	00 
    1612:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1619:	e8 bf 09 00 00       	call   1fdd <printf>
    161e:	a1 c8 27 00 00       	mov    0x27c8,%eax
    1623:	89 04 24             	mov    %eax,(%esp)
    1626:	e8 9e fb ff ff       	call   11c9 <sem_signal>
    162b:	e8 0c 08 00 00       	call   1e3c <exit>
    1630:	c7 05 dc 27 00 00 00 	movl   $0x0,0x27dc
    1637:	00 00 00 
    163a:	eb 0d                	jmp    1649 <main+0x418>
    163c:	a1 dc 27 00 00       	mov    0x27dc,%eax
    1641:	83 c0 01             	add    $0x1,%eax
    1644:	a3 dc 27 00 00       	mov    %eax,0x27dc
    1649:	a1 dc 27 00 00       	mov    0x27dc,%eax
    164e:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    1653:	7e e7                	jle    163c <main+0x40b>
    1655:	a1 d8 27 00 00       	mov    0x27d8,%eax
    165a:	83 c0 01             	add    $0x1,%eax
    165d:	a3 d8 27 00 00       	mov    %eax,0x27d8
    1662:	a1 d8 27 00 00       	mov    0x27d8,%eax
    1667:	83 f8 09             	cmp    $0x9,%eax
    166a:	0f 8e 74 fe ff ff    	jle    14e4 <main+0x2b3>
    1670:	e8 cf 07 00 00       	call   1e44 <wait>
    1675:	85 c0                	test   %eax,%eax
    1677:	79 f7                	jns    1670 <main+0x43f>
    1679:	a1 c8 27 00 00       	mov    0x27c8,%eax
    167e:	89 04 24             	mov    %eax,(%esp)
    1681:	e8 c4 fa ff ff       	call   114a <sem_acquire>
    1686:	c7 44 24 04 b8 26 00 	movl   $0x26b8,0x4(%esp)
    168d:	00 
    168e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1695:	e8 43 09 00 00       	call   1fdd <printf>
    169a:	a1 c8 27 00 00       	mov    0x27c8,%eax
    169f:	89 04 24             	mov    %eax,(%esp)
    16a2:	e8 22 fb ff ff       	call   11c9 <sem_signal>
    16a7:	a1 c0 27 00 00       	mov    0x27c0,%eax
    16ac:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    16b3:	00 
    16b4:	89 04 24             	mov    %eax,(%esp)
    16b7:	e8 59 fa ff ff       	call   1115 <sem_init>
    16bc:	a1 c4 27 00 00       	mov    0x27c4,%eax
    16c1:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    16c8:	00 
    16c9:	89 04 24             	mov    %eax,(%esp)
    16cc:	e8 44 fa ff ff       	call   1115 <sem_init>
    16d1:	c7 05 d8 27 00 00 00 	movl   $0x0,0x27d8
    16d8:	00 00 00 
    16db:	e9 7e 01 00 00       	jmp    185e <main+0x62d>
    16e0:	b8 76 1a 00 00       	mov    $0x1a76,%eax
    16e5:	c7 44 24 04 a4 27 00 	movl   $0x27a4,0x4(%esp)
    16ec:	00 
    16ed:	89 04 24             	mov    %eax,(%esp)
    16f0:	e8 11 0d 00 00       	call   2406 <thread_create>
    16f5:	a3 e0 27 00 00       	mov    %eax,0x27e0
    16fa:	a1 e0 27 00 00       	mov    0x27e0,%eax
    16ff:	85 c0                	test   %eax,%eax
    1701:	75 33                	jne    1736 <main+0x505>
    1703:	a1 c8 27 00 00       	mov    0x27c8,%eax
    1708:	89 04 24             	mov    %eax,(%esp)
    170b:	e8 3a fa ff ff       	call   114a <sem_acquire>
    1710:	c7 44 24 04 59 26 00 	movl   $0x2659,0x4(%esp)
    1717:	00 
    1718:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    171f:	e8 b9 08 00 00       	call   1fdd <printf>
    1724:	a1 c8 27 00 00       	mov    0x27c8,%eax
    1729:	89 04 24             	mov    %eax,(%esp)
    172c:	e8 98 fa ff ff       	call   11c9 <sem_signal>
    1731:	e8 06 07 00 00       	call   1e3c <exit>
    1736:	c7 05 dc 27 00 00 00 	movl   $0x0,0x27dc
    173d:	00 00 00 
    1740:	eb 0d                	jmp    174f <main+0x51e>
    1742:	a1 dc 27 00 00       	mov    0x27dc,%eax
    1747:	83 c0 01             	add    $0x1,%eax
    174a:	a3 dc 27 00 00       	mov    %eax,0x27dc
    174f:	a1 dc 27 00 00       	mov    0x27dc,%eax
    1754:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    1759:	7e e7                	jle    1742 <main+0x511>
    175b:	b8 27 1b 00 00       	mov    $0x1b27,%eax
    1760:	c7 44 24 04 a4 27 00 	movl   $0x27a4,0x4(%esp)
    1767:	00 
    1768:	89 04 24             	mov    %eax,(%esp)
    176b:	e8 96 0c 00 00       	call   2406 <thread_create>
    1770:	a3 e0 27 00 00       	mov    %eax,0x27e0
    1775:	a1 e0 27 00 00       	mov    0x27e0,%eax
    177a:	85 c0                	test   %eax,%eax
    177c:	75 33                	jne    17b1 <main+0x580>
    177e:	a1 c8 27 00 00       	mov    0x27c8,%eax
    1783:	89 04 24             	mov    %eax,(%esp)
    1786:	e8 bf f9 ff ff       	call   114a <sem_acquire>
    178b:	c7 44 24 04 59 26 00 	movl   $0x2659,0x4(%esp)
    1792:	00 
    1793:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    179a:	e8 3e 08 00 00       	call   1fdd <printf>
    179f:	a1 c8 27 00 00       	mov    0x27c8,%eax
    17a4:	89 04 24             	mov    %eax,(%esp)
    17a7:	e8 1d fa ff ff       	call   11c9 <sem_signal>
    17ac:	e8 8b 06 00 00       	call   1e3c <exit>
    17b1:	c7 05 dc 27 00 00 00 	movl   $0x0,0x27dc
    17b8:	00 00 00 
    17bb:	eb 0d                	jmp    17ca <main+0x599>
    17bd:	a1 dc 27 00 00       	mov    0x27dc,%eax
    17c2:	83 c0 01             	add    $0x1,%eax
    17c5:	a3 dc 27 00 00       	mov    %eax,0x27dc
    17ca:	a1 dc 27 00 00       	mov    0x27dc,%eax
    17cf:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    17d4:	7e e7                	jle    17bd <main+0x58c>
    17d6:	b8 76 1a 00 00       	mov    $0x1a76,%eax
    17db:	c7 44 24 04 a4 27 00 	movl   $0x27a4,0x4(%esp)
    17e2:	00 
    17e3:	89 04 24             	mov    %eax,(%esp)
    17e6:	e8 1b 0c 00 00       	call   2406 <thread_create>
    17eb:	a3 e0 27 00 00       	mov    %eax,0x27e0
    17f0:	a1 e0 27 00 00       	mov    0x27e0,%eax
    17f5:	85 c0                	test   %eax,%eax
    17f7:	75 33                	jne    182c <main+0x5fb>
    17f9:	a1 c8 27 00 00       	mov    0x27c8,%eax
    17fe:	89 04 24             	mov    %eax,(%esp)
    1801:	e8 44 f9 ff ff       	call   114a <sem_acquire>
    1806:	c7 44 24 04 59 26 00 	movl   $0x2659,0x4(%esp)
    180d:	00 
    180e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1815:	e8 c3 07 00 00       	call   1fdd <printf>
    181a:	a1 c8 27 00 00       	mov    0x27c8,%eax
    181f:	89 04 24             	mov    %eax,(%esp)
    1822:	e8 a2 f9 ff ff       	call   11c9 <sem_signal>
    1827:	e8 10 06 00 00       	call   1e3c <exit>
    182c:	c7 05 dc 27 00 00 00 	movl   $0x0,0x27dc
    1833:	00 00 00 
    1836:	eb 0d                	jmp    1845 <main+0x614>
    1838:	a1 dc 27 00 00       	mov    0x27dc,%eax
    183d:	83 c0 01             	add    $0x1,%eax
    1840:	a3 dc 27 00 00       	mov    %eax,0x27dc
    1845:	a1 dc 27 00 00       	mov    0x27dc,%eax
    184a:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    184f:	7e e7                	jle    1838 <main+0x607>
    1851:	a1 d8 27 00 00       	mov    0x27d8,%eax
    1856:	83 c0 01             	add    $0x1,%eax
    1859:	a3 d8 27 00 00       	mov    %eax,0x27d8
    185e:	a1 d8 27 00 00       	mov    0x27d8,%eax
    1863:	83 f8 09             	cmp    $0x9,%eax
    1866:	0f 8e 74 fe ff ff    	jle    16e0 <main+0x4af>
    186c:	e8 d3 05 00 00       	call   1e44 <wait>
    1871:	85 c0                	test   %eax,%eax
    1873:	79 f7                	jns    186c <main+0x63b>
    1875:	a1 c8 27 00 00       	mov    0x27c8,%eax
    187a:	89 04 24             	mov    %eax,(%esp)
    187d:	e8 c8 f8 ff ff       	call   114a <sem_acquire>
    1882:	c7 44 24 04 fc 26 00 	movl   $0x26fc,0x4(%esp)
    1889:	00 
    188a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1891:	e8 47 07 00 00       	call   1fdd <printf>
    1896:	a1 c8 27 00 00       	mov    0x27c8,%eax
    189b:	89 04 24             	mov    %eax,(%esp)
    189e:	e8 26 f9 ff ff       	call   11c9 <sem_signal>
    18a3:	a1 c0 27 00 00       	mov    0x27c0,%eax
    18a8:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    18af:	00 
    18b0:	89 04 24             	mov    %eax,(%esp)
    18b3:	e8 5d f8 ff ff       	call   1115 <sem_init>
    18b8:	a1 c4 27 00 00       	mov    0x27c4,%eax
    18bd:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    18c4:	00 
    18c5:	89 04 24             	mov    %eax,(%esp)
    18c8:	e8 48 f8 ff ff       	call   1115 <sem_init>
    18cd:	c7 05 d8 27 00 00 00 	movl   $0x0,0x27d8
    18d4:	00 00 00 
    18d7:	e9 7e 01 00 00       	jmp    1a5a <main+0x829>
    18dc:	b8 76 1a 00 00       	mov    $0x1a76,%eax
    18e1:	c7 44 24 04 a4 27 00 	movl   $0x27a4,0x4(%esp)
    18e8:	00 
    18e9:	89 04 24             	mov    %eax,(%esp)
    18ec:	e8 15 0b 00 00       	call   2406 <thread_create>
    18f1:	a3 e0 27 00 00       	mov    %eax,0x27e0
    18f6:	a1 e0 27 00 00       	mov    0x27e0,%eax
    18fb:	85 c0                	test   %eax,%eax
    18fd:	75 33                	jne    1932 <main+0x701>
    18ff:	a1 c8 27 00 00       	mov    0x27c8,%eax
    1904:	89 04 24             	mov    %eax,(%esp)
    1907:	e8 3e f8 ff ff       	call   114a <sem_acquire>
    190c:	c7 44 24 04 59 26 00 	movl   $0x2659,0x4(%esp)
    1913:	00 
    1914:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    191b:	e8 bd 06 00 00       	call   1fdd <printf>
    1920:	a1 c8 27 00 00       	mov    0x27c8,%eax
    1925:	89 04 24             	mov    %eax,(%esp)
    1928:	e8 9c f8 ff ff       	call   11c9 <sem_signal>
    192d:	e8 0a 05 00 00       	call   1e3c <exit>
    1932:	c7 05 dc 27 00 00 00 	movl   $0x0,0x27dc
    1939:	00 00 00 
    193c:	eb 0d                	jmp    194b <main+0x71a>
    193e:	a1 dc 27 00 00       	mov    0x27dc,%eax
    1943:	83 c0 01             	add    $0x1,%eax
    1946:	a3 dc 27 00 00       	mov    %eax,0x27dc
    194b:	a1 dc 27 00 00       	mov    0x27dc,%eax
    1950:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    1955:	7e e7                	jle    193e <main+0x70d>
    1957:	b8 76 1a 00 00       	mov    $0x1a76,%eax
    195c:	c7 44 24 04 a4 27 00 	movl   $0x27a4,0x4(%esp)
    1963:	00 
    1964:	89 04 24             	mov    %eax,(%esp)
    1967:	e8 9a 0a 00 00       	call   2406 <thread_create>
    196c:	a3 e0 27 00 00       	mov    %eax,0x27e0
    1971:	a1 e0 27 00 00       	mov    0x27e0,%eax
    1976:	85 c0                	test   %eax,%eax
    1978:	75 33                	jne    19ad <main+0x77c>
    197a:	a1 c8 27 00 00       	mov    0x27c8,%eax
    197f:	89 04 24             	mov    %eax,(%esp)
    1982:	e8 c3 f7 ff ff       	call   114a <sem_acquire>
    1987:	c7 44 24 04 59 26 00 	movl   $0x2659,0x4(%esp)
    198e:	00 
    198f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1996:	e8 42 06 00 00       	call   1fdd <printf>
    199b:	a1 c8 27 00 00       	mov    0x27c8,%eax
    19a0:	89 04 24             	mov    %eax,(%esp)
    19a3:	e8 21 f8 ff ff       	call   11c9 <sem_signal>
    19a8:	e8 8f 04 00 00       	call   1e3c <exit>
    19ad:	c7 05 dc 27 00 00 00 	movl   $0x0,0x27dc
    19b4:	00 00 00 
    19b7:	eb 0d                	jmp    19c6 <main+0x795>
    19b9:	a1 dc 27 00 00       	mov    0x27dc,%eax
    19be:	83 c0 01             	add    $0x1,%eax
    19c1:	a3 dc 27 00 00       	mov    %eax,0x27dc
    19c6:	a1 dc 27 00 00       	mov    0x27dc,%eax
    19cb:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    19d0:	7e e7                	jle    19b9 <main+0x788>
    19d2:	b8 27 1b 00 00       	mov    $0x1b27,%eax
    19d7:	c7 44 24 04 a4 27 00 	movl   $0x27a4,0x4(%esp)
    19de:	00 
    19df:	89 04 24             	mov    %eax,(%esp)
    19e2:	e8 1f 0a 00 00       	call   2406 <thread_create>
    19e7:	a3 e0 27 00 00       	mov    %eax,0x27e0
    19ec:	a1 e0 27 00 00       	mov    0x27e0,%eax
    19f1:	85 c0                	test   %eax,%eax
    19f3:	75 33                	jne    1a28 <main+0x7f7>
    19f5:	a1 c8 27 00 00       	mov    0x27c8,%eax
    19fa:	89 04 24             	mov    %eax,(%esp)
    19fd:	e8 48 f7 ff ff       	call   114a <sem_acquire>
    1a02:	c7 44 24 04 59 26 00 	movl   $0x2659,0x4(%esp)
    1a09:	00 
    1a0a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1a11:	e8 c7 05 00 00       	call   1fdd <printf>
    1a16:	a1 c8 27 00 00       	mov    0x27c8,%eax
    1a1b:	89 04 24             	mov    %eax,(%esp)
    1a1e:	e8 a6 f7 ff ff       	call   11c9 <sem_signal>
    1a23:	e8 14 04 00 00       	call   1e3c <exit>
    1a28:	c7 05 dc 27 00 00 00 	movl   $0x0,0x27dc
    1a2f:	00 00 00 
    1a32:	eb 0d                	jmp    1a41 <main+0x810>
    1a34:	a1 dc 27 00 00       	mov    0x27dc,%eax
    1a39:	83 c0 01             	add    $0x1,%eax
    1a3c:	a3 dc 27 00 00       	mov    %eax,0x27dc
    1a41:	a1 dc 27 00 00       	mov    0x27dc,%eax
    1a46:	3d 3e 42 0f 00       	cmp    $0xf423e,%eax
    1a4b:	7e e7                	jle    1a34 <main+0x803>
    1a4d:	a1 d8 27 00 00       	mov    0x27d8,%eax
    1a52:	83 c0 01             	add    $0x1,%eax
    1a55:	a3 d8 27 00 00       	mov    %eax,0x27d8
    1a5a:	a1 d8 27 00 00       	mov    0x27d8,%eax
    1a5f:	83 f8 09             	cmp    $0x9,%eax
    1a62:	0f 8e 74 fe ff ff    	jle    18dc <main+0x6ab>
    1a68:	e8 d7 03 00 00       	call   1e44 <wait>
    1a6d:	85 c0                	test   %eax,%eax
    1a6f:	79 f7                	jns    1a68 <main+0x837>
    1a71:	e8 c6 03 00 00       	call   1e3c <exit>

00001a76 <hReady>:
    1a76:	55                   	push   %ebp
    1a77:	89 e5                	mov    %esp,%ebp
    1a79:	83 ec 18             	sub    $0x18,%esp
    1a7c:	a1 c8 27 00 00       	mov    0x27c8,%eax
    1a81:	89 04 24             	mov    %eax,(%esp)
    1a84:	e8 c1 f6 ff ff       	call   114a <sem_acquire>
    1a89:	c7 44 24 04 40 27 00 	movl   $0x2740,0x4(%esp)
    1a90:	00 
    1a91:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1a98:	e8 40 05 00 00       	call   1fdd <printf>
    1a9d:	a1 c8 27 00 00       	mov    0x27c8,%eax
    1aa2:	89 04 24             	mov    %eax,(%esp)
    1aa5:	e8 1f f7 ff ff       	call   11c9 <sem_signal>
    1aaa:	a1 c0 27 00 00       	mov    0x27c0,%eax
    1aaf:	89 04 24             	mov    %eax,(%esp)
    1ab2:	e8 93 f6 ff ff       	call   114a <sem_acquire>
    1ab7:	a1 c0 27 00 00       	mov    0x27c0,%eax
    1abc:	8b 00                	mov    (%eax),%eax
    1abe:	85 c0                	test   %eax,%eax
    1ac0:	75 60                	jne    1b22 <hReady+0xac>
    1ac2:	a1 c4 27 00 00       	mov    0x27c4,%eax
    1ac7:	8b 00                	mov    (%eax),%eax
    1ac9:	85 c0                	test   %eax,%eax
    1acb:	75 55                	jne    1b22 <hReady+0xac>
    1acd:	a1 c8 27 00 00       	mov    0x27c8,%eax
    1ad2:	89 04 24             	mov    %eax,(%esp)
    1ad5:	e8 70 f6 ff ff       	call   114a <sem_acquire>
    1ada:	c7 44 24 04 50 27 00 	movl   $0x2750,0x4(%esp)
    1ae1:	00 
    1ae2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1ae9:	e8 ef 04 00 00       	call   1fdd <printf>
    1aee:	a1 c8 27 00 00       	mov    0x27c8,%eax
    1af3:	89 04 24             	mov    %eax,(%esp)
    1af6:	e8 ce f6 ff ff       	call   11c9 <sem_signal>
    1afb:	a1 c0 27 00 00       	mov    0x27c0,%eax
    1b00:	89 04 24             	mov    %eax,(%esp)
    1b03:	e8 c1 f6 ff ff       	call   11c9 <sem_signal>
    1b08:	a1 c0 27 00 00       	mov    0x27c0,%eax
    1b0d:	89 04 24             	mov    %eax,(%esp)
    1b10:	e8 b4 f6 ff ff       	call   11c9 <sem_signal>
    1b15:	a1 c4 27 00 00       	mov    0x27c4,%eax
    1b1a:	89 04 24             	mov    %eax,(%esp)
    1b1d:	e8 a7 f6 ff ff       	call   11c9 <sem_signal>
    1b22:	e8 bd 03 00 00       	call   1ee4 <texit>

00001b27 <oReady>:
    1b27:	55                   	push   %ebp
    1b28:	89 e5                	mov    %esp,%ebp
    1b2a:	83 ec 18             	sub    $0x18,%esp
    1b2d:	a1 c8 27 00 00       	mov    0x27c8,%eax
    1b32:	89 04 24             	mov    %eax,(%esp)
    1b35:	e8 10 f6 ff ff       	call   114a <sem_acquire>
    1b3a:	c7 44 24 04 61 27 00 	movl   $0x2761,0x4(%esp)
    1b41:	00 
    1b42:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1b49:	e8 8f 04 00 00       	call   1fdd <printf>
    1b4e:	a1 c8 27 00 00       	mov    0x27c8,%eax
    1b53:	89 04 24             	mov    %eax,(%esp)
    1b56:	e8 6e f6 ff ff       	call   11c9 <sem_signal>
    1b5b:	a1 c4 27 00 00       	mov    0x27c4,%eax
    1b60:	89 04 24             	mov    %eax,(%esp)
    1b63:	e8 e2 f5 ff ff       	call   114a <sem_acquire>
    1b68:	a1 c0 27 00 00       	mov    0x27c0,%eax
    1b6d:	8b 00                	mov    (%eax),%eax
    1b6f:	85 c0                	test   %eax,%eax
    1b71:	75 60                	jne    1bd3 <oReady+0xac>
    1b73:	a1 c4 27 00 00       	mov    0x27c4,%eax
    1b78:	8b 00                	mov    (%eax),%eax
    1b7a:	85 c0                	test   %eax,%eax
    1b7c:	75 55                	jne    1bd3 <oReady+0xac>
    1b7e:	a1 c8 27 00 00       	mov    0x27c8,%eax
    1b83:	89 04 24             	mov    %eax,(%esp)
    1b86:	e8 bf f5 ff ff       	call   114a <sem_acquire>
    1b8b:	c7 44 24 04 50 27 00 	movl   $0x2750,0x4(%esp)
    1b92:	00 
    1b93:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1b9a:	e8 3e 04 00 00       	call   1fdd <printf>
    1b9f:	a1 c8 27 00 00       	mov    0x27c8,%eax
    1ba4:	89 04 24             	mov    %eax,(%esp)
    1ba7:	e8 1d f6 ff ff       	call   11c9 <sem_signal>
    1bac:	a1 c0 27 00 00       	mov    0x27c0,%eax
    1bb1:	89 04 24             	mov    %eax,(%esp)
    1bb4:	e8 10 f6 ff ff       	call   11c9 <sem_signal>
    1bb9:	a1 c0 27 00 00       	mov    0x27c0,%eax
    1bbe:	89 04 24             	mov    %eax,(%esp)
    1bc1:	e8 03 f6 ff ff       	call   11c9 <sem_signal>
    1bc6:	a1 c4 27 00 00       	mov    0x27c4,%eax
    1bcb:	89 04 24             	mov    %eax,(%esp)
    1bce:	e8 f6 f5 ff ff       	call   11c9 <sem_signal>
    1bd3:	e8 0c 03 00 00       	call   1ee4 <texit>

00001bd8 <stosb>:
    1bd8:	55                   	push   %ebp
    1bd9:	89 e5                	mov    %esp,%ebp
    1bdb:	57                   	push   %edi
    1bdc:	53                   	push   %ebx
    1bdd:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1be0:	8b 55 10             	mov    0x10(%ebp),%edx
    1be3:	8b 45 0c             	mov    0xc(%ebp),%eax
    1be6:	89 cb                	mov    %ecx,%ebx
    1be8:	89 df                	mov    %ebx,%edi
    1bea:	89 d1                	mov    %edx,%ecx
    1bec:	fc                   	cld    
    1bed:	f3 aa                	rep stos %al,%es:(%edi)
    1bef:	89 ca                	mov    %ecx,%edx
    1bf1:	89 fb                	mov    %edi,%ebx
    1bf3:	89 5d 08             	mov    %ebx,0x8(%ebp)
    1bf6:	89 55 10             	mov    %edx,0x10(%ebp)
    1bf9:	5b                   	pop    %ebx
    1bfa:	5f                   	pop    %edi
    1bfb:	5d                   	pop    %ebp
    1bfc:	c3                   	ret    

00001bfd <strcpy>:
    1bfd:	55                   	push   %ebp
    1bfe:	89 e5                	mov    %esp,%ebp
    1c00:	83 ec 10             	sub    $0x10,%esp
    1c03:	8b 45 08             	mov    0x8(%ebp),%eax
    1c06:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1c09:	8b 45 0c             	mov    0xc(%ebp),%eax
    1c0c:	0f b6 10             	movzbl (%eax),%edx
    1c0f:	8b 45 08             	mov    0x8(%ebp),%eax
    1c12:	88 10                	mov    %dl,(%eax)
    1c14:	8b 45 08             	mov    0x8(%ebp),%eax
    1c17:	0f b6 00             	movzbl (%eax),%eax
    1c1a:	84 c0                	test   %al,%al
    1c1c:	0f 95 c0             	setne  %al
    1c1f:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1c23:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    1c27:	84 c0                	test   %al,%al
    1c29:	75 de                	jne    1c09 <strcpy+0xc>
    1c2b:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1c2e:	c9                   	leave  
    1c2f:	c3                   	ret    

00001c30 <strcmp>:
    1c30:	55                   	push   %ebp
    1c31:	89 e5                	mov    %esp,%ebp
    1c33:	eb 08                	jmp    1c3d <strcmp+0xd>
    1c35:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1c39:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    1c3d:	8b 45 08             	mov    0x8(%ebp),%eax
    1c40:	0f b6 00             	movzbl (%eax),%eax
    1c43:	84 c0                	test   %al,%al
    1c45:	74 10                	je     1c57 <strcmp+0x27>
    1c47:	8b 45 08             	mov    0x8(%ebp),%eax
    1c4a:	0f b6 10             	movzbl (%eax),%edx
    1c4d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1c50:	0f b6 00             	movzbl (%eax),%eax
    1c53:	38 c2                	cmp    %al,%dl
    1c55:	74 de                	je     1c35 <strcmp+0x5>
    1c57:	8b 45 08             	mov    0x8(%ebp),%eax
    1c5a:	0f b6 00             	movzbl (%eax),%eax
    1c5d:	0f b6 d0             	movzbl %al,%edx
    1c60:	8b 45 0c             	mov    0xc(%ebp),%eax
    1c63:	0f b6 00             	movzbl (%eax),%eax
    1c66:	0f b6 c0             	movzbl %al,%eax
    1c69:	89 d1                	mov    %edx,%ecx
    1c6b:	29 c1                	sub    %eax,%ecx
    1c6d:	89 c8                	mov    %ecx,%eax
    1c6f:	5d                   	pop    %ebp
    1c70:	c3                   	ret    

00001c71 <strlen>:
    1c71:	55                   	push   %ebp
    1c72:	89 e5                	mov    %esp,%ebp
    1c74:	83 ec 10             	sub    $0x10,%esp
    1c77:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    1c7e:	eb 04                	jmp    1c84 <strlen+0x13>
    1c80:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    1c84:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1c87:	03 45 08             	add    0x8(%ebp),%eax
    1c8a:	0f b6 00             	movzbl (%eax),%eax
    1c8d:	84 c0                	test   %al,%al
    1c8f:	75 ef                	jne    1c80 <strlen+0xf>
    1c91:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1c94:	c9                   	leave  
    1c95:	c3                   	ret    

00001c96 <memset>:
    1c96:	55                   	push   %ebp
    1c97:	89 e5                	mov    %esp,%ebp
    1c99:	83 ec 0c             	sub    $0xc,%esp
    1c9c:	8b 45 10             	mov    0x10(%ebp),%eax
    1c9f:	89 44 24 08          	mov    %eax,0x8(%esp)
    1ca3:	8b 45 0c             	mov    0xc(%ebp),%eax
    1ca6:	89 44 24 04          	mov    %eax,0x4(%esp)
    1caa:	8b 45 08             	mov    0x8(%ebp),%eax
    1cad:	89 04 24             	mov    %eax,(%esp)
    1cb0:	e8 23 ff ff ff       	call   1bd8 <stosb>
    1cb5:	8b 45 08             	mov    0x8(%ebp),%eax
    1cb8:	c9                   	leave  
    1cb9:	c3                   	ret    

00001cba <strchr>:
    1cba:	55                   	push   %ebp
    1cbb:	89 e5                	mov    %esp,%ebp
    1cbd:	83 ec 04             	sub    $0x4,%esp
    1cc0:	8b 45 0c             	mov    0xc(%ebp),%eax
    1cc3:	88 45 fc             	mov    %al,-0x4(%ebp)
    1cc6:	eb 14                	jmp    1cdc <strchr+0x22>
    1cc8:	8b 45 08             	mov    0x8(%ebp),%eax
    1ccb:	0f b6 00             	movzbl (%eax),%eax
    1cce:	3a 45 fc             	cmp    -0x4(%ebp),%al
    1cd1:	75 05                	jne    1cd8 <strchr+0x1e>
    1cd3:	8b 45 08             	mov    0x8(%ebp),%eax
    1cd6:	eb 13                	jmp    1ceb <strchr+0x31>
    1cd8:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1cdc:	8b 45 08             	mov    0x8(%ebp),%eax
    1cdf:	0f b6 00             	movzbl (%eax),%eax
    1ce2:	84 c0                	test   %al,%al
    1ce4:	75 e2                	jne    1cc8 <strchr+0xe>
    1ce6:	b8 00 00 00 00       	mov    $0x0,%eax
    1ceb:	c9                   	leave  
    1cec:	c3                   	ret    

00001ced <gets>:
    1ced:	55                   	push   %ebp
    1cee:	89 e5                	mov    %esp,%ebp
    1cf0:	83 ec 28             	sub    $0x28,%esp
    1cf3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1cfa:	eb 44                	jmp    1d40 <gets+0x53>
    1cfc:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1d03:	00 
    1d04:	8d 45 ef             	lea    -0x11(%ebp),%eax
    1d07:	89 44 24 04          	mov    %eax,0x4(%esp)
    1d0b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1d12:	e8 3d 01 00 00       	call   1e54 <read>
    1d17:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1d1a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1d1e:	7e 2d                	jle    1d4d <gets+0x60>
    1d20:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1d23:	03 45 08             	add    0x8(%ebp),%eax
    1d26:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
    1d2a:	88 10                	mov    %dl,(%eax)
    1d2c:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1d30:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1d34:	3c 0a                	cmp    $0xa,%al
    1d36:	74 16                	je     1d4e <gets+0x61>
    1d38:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1d3c:	3c 0d                	cmp    $0xd,%al
    1d3e:	74 0e                	je     1d4e <gets+0x61>
    1d40:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1d43:	83 c0 01             	add    $0x1,%eax
    1d46:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1d49:	7c b1                	jl     1cfc <gets+0xf>
    1d4b:	eb 01                	jmp    1d4e <gets+0x61>
    1d4d:	90                   	nop
    1d4e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1d51:	03 45 08             	add    0x8(%ebp),%eax
    1d54:	c6 00 00             	movb   $0x0,(%eax)
    1d57:	8b 45 08             	mov    0x8(%ebp),%eax
    1d5a:	c9                   	leave  
    1d5b:	c3                   	ret    

00001d5c <stat>:
    1d5c:	55                   	push   %ebp
    1d5d:	89 e5                	mov    %esp,%ebp
    1d5f:	83 ec 28             	sub    $0x28,%esp
    1d62:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1d69:	00 
    1d6a:	8b 45 08             	mov    0x8(%ebp),%eax
    1d6d:	89 04 24             	mov    %eax,(%esp)
    1d70:	e8 07 01 00 00       	call   1e7c <open>
    1d75:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1d78:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1d7c:	79 07                	jns    1d85 <stat+0x29>
    1d7e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1d83:	eb 23                	jmp    1da8 <stat+0x4c>
    1d85:	8b 45 0c             	mov    0xc(%ebp),%eax
    1d88:	89 44 24 04          	mov    %eax,0x4(%esp)
    1d8c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1d8f:	89 04 24             	mov    %eax,(%esp)
    1d92:	e8 fd 00 00 00       	call   1e94 <fstat>
    1d97:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1d9a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1d9d:	89 04 24             	mov    %eax,(%esp)
    1da0:	e8 bf 00 00 00       	call   1e64 <close>
    1da5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1da8:	c9                   	leave  
    1da9:	c3                   	ret    

00001daa <atoi>:
    1daa:	55                   	push   %ebp
    1dab:	89 e5                	mov    %esp,%ebp
    1dad:	83 ec 10             	sub    $0x10,%esp
    1db0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    1db7:	eb 24                	jmp    1ddd <atoi+0x33>
    1db9:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1dbc:	89 d0                	mov    %edx,%eax
    1dbe:	c1 e0 02             	shl    $0x2,%eax
    1dc1:	01 d0                	add    %edx,%eax
    1dc3:	01 c0                	add    %eax,%eax
    1dc5:	89 c2                	mov    %eax,%edx
    1dc7:	8b 45 08             	mov    0x8(%ebp),%eax
    1dca:	0f b6 00             	movzbl (%eax),%eax
    1dcd:	0f be c0             	movsbl %al,%eax
    1dd0:	8d 04 02             	lea    (%edx,%eax,1),%eax
    1dd3:	83 e8 30             	sub    $0x30,%eax
    1dd6:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1dd9:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1ddd:	8b 45 08             	mov    0x8(%ebp),%eax
    1de0:	0f b6 00             	movzbl (%eax),%eax
    1de3:	3c 2f                	cmp    $0x2f,%al
    1de5:	7e 0a                	jle    1df1 <atoi+0x47>
    1de7:	8b 45 08             	mov    0x8(%ebp),%eax
    1dea:	0f b6 00             	movzbl (%eax),%eax
    1ded:	3c 39                	cmp    $0x39,%al
    1def:	7e c8                	jle    1db9 <atoi+0xf>
    1df1:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1df4:	c9                   	leave  
    1df5:	c3                   	ret    

00001df6 <memmove>:
    1df6:	55                   	push   %ebp
    1df7:	89 e5                	mov    %esp,%ebp
    1df9:	83 ec 10             	sub    $0x10,%esp
    1dfc:	8b 45 08             	mov    0x8(%ebp),%eax
    1dff:	89 45 f8             	mov    %eax,-0x8(%ebp)
    1e02:	8b 45 0c             	mov    0xc(%ebp),%eax
    1e05:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1e08:	eb 13                	jmp    1e1d <memmove+0x27>
    1e0a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1e0d:	0f b6 10             	movzbl (%eax),%edx
    1e10:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1e13:	88 10                	mov    %dl,(%eax)
    1e15:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    1e19:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    1e1d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1e21:	0f 9f c0             	setg   %al
    1e24:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    1e28:	84 c0                	test   %al,%al
    1e2a:	75 de                	jne    1e0a <memmove+0x14>
    1e2c:	8b 45 08             	mov    0x8(%ebp),%eax
    1e2f:	c9                   	leave  
    1e30:	c3                   	ret    
    1e31:	90                   	nop
    1e32:	90                   	nop
    1e33:	90                   	nop

00001e34 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    1e34:	b8 01 00 00 00       	mov    $0x1,%eax
    1e39:	cd 40                	int    $0x40
    1e3b:	c3                   	ret    

00001e3c <exit>:
SYSCALL(exit)
    1e3c:	b8 02 00 00 00       	mov    $0x2,%eax
    1e41:	cd 40                	int    $0x40
    1e43:	c3                   	ret    

00001e44 <wait>:
SYSCALL(wait)
    1e44:	b8 03 00 00 00       	mov    $0x3,%eax
    1e49:	cd 40                	int    $0x40
    1e4b:	c3                   	ret    

00001e4c <pipe>:
SYSCALL(pipe)
    1e4c:	b8 04 00 00 00       	mov    $0x4,%eax
    1e51:	cd 40                	int    $0x40
    1e53:	c3                   	ret    

00001e54 <read>:
SYSCALL(read)
    1e54:	b8 05 00 00 00       	mov    $0x5,%eax
    1e59:	cd 40                	int    $0x40
    1e5b:	c3                   	ret    

00001e5c <write>:
SYSCALL(write)
    1e5c:	b8 10 00 00 00       	mov    $0x10,%eax
    1e61:	cd 40                	int    $0x40
    1e63:	c3                   	ret    

00001e64 <close>:
SYSCALL(close)
    1e64:	b8 15 00 00 00       	mov    $0x15,%eax
    1e69:	cd 40                	int    $0x40
    1e6b:	c3                   	ret    

00001e6c <kill>:
SYSCALL(kill)
    1e6c:	b8 06 00 00 00       	mov    $0x6,%eax
    1e71:	cd 40                	int    $0x40
    1e73:	c3                   	ret    

00001e74 <exec>:
SYSCALL(exec)
    1e74:	b8 07 00 00 00       	mov    $0x7,%eax
    1e79:	cd 40                	int    $0x40
    1e7b:	c3                   	ret    

00001e7c <open>:
SYSCALL(open)
    1e7c:	b8 0f 00 00 00       	mov    $0xf,%eax
    1e81:	cd 40                	int    $0x40
    1e83:	c3                   	ret    

00001e84 <mknod>:
SYSCALL(mknod)
    1e84:	b8 11 00 00 00       	mov    $0x11,%eax
    1e89:	cd 40                	int    $0x40
    1e8b:	c3                   	ret    

00001e8c <unlink>:
SYSCALL(unlink)
    1e8c:	b8 12 00 00 00       	mov    $0x12,%eax
    1e91:	cd 40                	int    $0x40
    1e93:	c3                   	ret    

00001e94 <fstat>:
SYSCALL(fstat)
    1e94:	b8 08 00 00 00       	mov    $0x8,%eax
    1e99:	cd 40                	int    $0x40
    1e9b:	c3                   	ret    

00001e9c <link>:
SYSCALL(link)
    1e9c:	b8 13 00 00 00       	mov    $0x13,%eax
    1ea1:	cd 40                	int    $0x40
    1ea3:	c3                   	ret    

00001ea4 <mkdir>:
SYSCALL(mkdir)
    1ea4:	b8 14 00 00 00       	mov    $0x14,%eax
    1ea9:	cd 40                	int    $0x40
    1eab:	c3                   	ret    

00001eac <chdir>:
SYSCALL(chdir)
    1eac:	b8 09 00 00 00       	mov    $0x9,%eax
    1eb1:	cd 40                	int    $0x40
    1eb3:	c3                   	ret    

00001eb4 <dup>:
SYSCALL(dup)
    1eb4:	b8 0a 00 00 00       	mov    $0xa,%eax
    1eb9:	cd 40                	int    $0x40
    1ebb:	c3                   	ret    

00001ebc <getpid>:
SYSCALL(getpid)
    1ebc:	b8 0b 00 00 00       	mov    $0xb,%eax
    1ec1:	cd 40                	int    $0x40
    1ec3:	c3                   	ret    

00001ec4 <sbrk>:
SYSCALL(sbrk)
    1ec4:	b8 0c 00 00 00       	mov    $0xc,%eax
    1ec9:	cd 40                	int    $0x40
    1ecb:	c3                   	ret    

00001ecc <sleep>:
SYSCALL(sleep)
    1ecc:	b8 0d 00 00 00       	mov    $0xd,%eax
    1ed1:	cd 40                	int    $0x40
    1ed3:	c3                   	ret    

00001ed4 <uptime>:
SYSCALL(uptime)
    1ed4:	b8 0e 00 00 00       	mov    $0xe,%eax
    1ed9:	cd 40                	int    $0x40
    1edb:	c3                   	ret    

00001edc <clone>:
SYSCALL(clone)
    1edc:	b8 16 00 00 00       	mov    $0x16,%eax
    1ee1:	cd 40                	int    $0x40
    1ee3:	c3                   	ret    

00001ee4 <texit>:
SYSCALL(texit)
    1ee4:	b8 17 00 00 00       	mov    $0x17,%eax
    1ee9:	cd 40                	int    $0x40
    1eeb:	c3                   	ret    

00001eec <tsleep>:
SYSCALL(tsleep)
    1eec:	b8 18 00 00 00       	mov    $0x18,%eax
    1ef1:	cd 40                	int    $0x40
    1ef3:	c3                   	ret    

00001ef4 <twakeup>:
SYSCALL(twakeup)
    1ef4:	b8 19 00 00 00       	mov    $0x19,%eax
    1ef9:	cd 40                	int    $0x40
    1efb:	c3                   	ret    

00001efc <thread_yield>:
SYSCALL(thread_yield)
    1efc:	b8 1a 00 00 00       	mov    $0x1a,%eax
    1f01:	cd 40                	int    $0x40
    1f03:	c3                   	ret    

00001f04 <putc>:
    1f04:	55                   	push   %ebp
    1f05:	89 e5                	mov    %esp,%ebp
    1f07:	83 ec 28             	sub    $0x28,%esp
    1f0a:	8b 45 0c             	mov    0xc(%ebp),%eax
    1f0d:	88 45 f4             	mov    %al,-0xc(%ebp)
    1f10:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1f17:	00 
    1f18:	8d 45 f4             	lea    -0xc(%ebp),%eax
    1f1b:	89 44 24 04          	mov    %eax,0x4(%esp)
    1f1f:	8b 45 08             	mov    0x8(%ebp),%eax
    1f22:	89 04 24             	mov    %eax,(%esp)
    1f25:	e8 32 ff ff ff       	call   1e5c <write>
    1f2a:	c9                   	leave  
    1f2b:	c3                   	ret    

00001f2c <printint>:
    1f2c:	55                   	push   %ebp
    1f2d:	89 e5                	mov    %esp,%ebp
    1f2f:	53                   	push   %ebx
    1f30:	83 ec 44             	sub    $0x44,%esp
    1f33:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1f3a:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    1f3e:	74 17                	je     1f57 <printint+0x2b>
    1f40:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1f44:	79 11                	jns    1f57 <printint+0x2b>
    1f46:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    1f4d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1f50:	f7 d8                	neg    %eax
    1f52:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1f55:	eb 06                	jmp    1f5d <printint+0x31>
    1f57:	8b 45 0c             	mov    0xc(%ebp),%eax
    1f5a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1f5d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1f64:	8b 4d ec             	mov    -0x14(%ebp),%ecx
    1f67:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1f6a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1f6d:	ba 00 00 00 00       	mov    $0x0,%edx
    1f72:	f7 f3                	div    %ebx
    1f74:	89 d0                	mov    %edx,%eax
    1f76:	0f b6 80 a8 27 00 00 	movzbl 0x27a8(%eax),%eax
    1f7d:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
    1f81:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1f85:	8b 45 10             	mov    0x10(%ebp),%eax
    1f88:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    1f8b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1f8e:	ba 00 00 00 00       	mov    $0x0,%edx
    1f93:	f7 75 d4             	divl   -0x2c(%ebp)
    1f96:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1f99:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1f9d:	75 c5                	jne    1f64 <printint+0x38>
    1f9f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1fa3:	74 28                	je     1fcd <printint+0xa1>
    1fa5:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1fa8:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)
    1fad:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1fb1:	eb 1a                	jmp    1fcd <printint+0xa1>
    1fb3:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1fb6:	0f b6 44 05 dc       	movzbl -0x24(%ebp,%eax,1),%eax
    1fbb:	0f be c0             	movsbl %al,%eax
    1fbe:	89 44 24 04          	mov    %eax,0x4(%esp)
    1fc2:	8b 45 08             	mov    0x8(%ebp),%eax
    1fc5:	89 04 24             	mov    %eax,(%esp)
    1fc8:	e8 37 ff ff ff       	call   1f04 <putc>
    1fcd:	83 6d ec 01          	subl   $0x1,-0x14(%ebp)
    1fd1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1fd5:	79 dc                	jns    1fb3 <printint+0x87>
    1fd7:	83 c4 44             	add    $0x44,%esp
    1fda:	5b                   	pop    %ebx
    1fdb:	5d                   	pop    %ebp
    1fdc:	c3                   	ret    

00001fdd <printf>:
    1fdd:	55                   	push   %ebp
    1fde:	89 e5                	mov    %esp,%ebp
    1fe0:	83 ec 38             	sub    $0x38,%esp
    1fe3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1fea:	8d 45 0c             	lea    0xc(%ebp),%eax
    1fed:	83 c0 04             	add    $0x4,%eax
    1ff0:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1ff3:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1ffa:	e9 7e 01 00 00       	jmp    217d <printf+0x1a0>
    1fff:	8b 55 0c             	mov    0xc(%ebp),%edx
    2002:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2005:	8d 04 02             	lea    (%edx,%eax,1),%eax
    2008:	0f b6 00             	movzbl (%eax),%eax
    200b:	0f be c0             	movsbl %al,%eax
    200e:	25 ff 00 00 00       	and    $0xff,%eax
    2013:	89 45 e8             	mov    %eax,-0x18(%ebp)
    2016:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    201a:	75 2c                	jne    2048 <printf+0x6b>
    201c:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    2020:	75 0c                	jne    202e <printf+0x51>
    2022:	c7 45 f0 25 00 00 00 	movl   $0x25,-0x10(%ebp)
    2029:	e9 4b 01 00 00       	jmp    2179 <printf+0x19c>
    202e:	8b 45 e8             	mov    -0x18(%ebp),%eax
    2031:	0f be c0             	movsbl %al,%eax
    2034:	89 44 24 04          	mov    %eax,0x4(%esp)
    2038:	8b 45 08             	mov    0x8(%ebp),%eax
    203b:	89 04 24             	mov    %eax,(%esp)
    203e:	e8 c1 fe ff ff       	call   1f04 <putc>
    2043:	e9 31 01 00 00       	jmp    2179 <printf+0x19c>
    2048:	83 7d f0 25          	cmpl   $0x25,-0x10(%ebp)
    204c:	0f 85 27 01 00 00    	jne    2179 <printf+0x19c>
    2052:	83 7d e8 64          	cmpl   $0x64,-0x18(%ebp)
    2056:	75 2d                	jne    2085 <printf+0xa8>
    2058:	8b 45 f4             	mov    -0xc(%ebp),%eax
    205b:	8b 00                	mov    (%eax),%eax
    205d:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    2064:	00 
    2065:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    206c:	00 
    206d:	89 44 24 04          	mov    %eax,0x4(%esp)
    2071:	8b 45 08             	mov    0x8(%ebp),%eax
    2074:	89 04 24             	mov    %eax,(%esp)
    2077:	e8 b0 fe ff ff       	call   1f2c <printint>
    207c:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    2080:	e9 ed 00 00 00       	jmp    2172 <printf+0x195>
    2085:	83 7d e8 78          	cmpl   $0x78,-0x18(%ebp)
    2089:	74 06                	je     2091 <printf+0xb4>
    208b:	83 7d e8 70          	cmpl   $0x70,-0x18(%ebp)
    208f:	75 2d                	jne    20be <printf+0xe1>
    2091:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2094:	8b 00                	mov    (%eax),%eax
    2096:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    209d:	00 
    209e:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    20a5:	00 
    20a6:	89 44 24 04          	mov    %eax,0x4(%esp)
    20aa:	8b 45 08             	mov    0x8(%ebp),%eax
    20ad:	89 04 24             	mov    %eax,(%esp)
    20b0:	e8 77 fe ff ff       	call   1f2c <printint>
    20b5:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    20b9:	e9 b4 00 00 00       	jmp    2172 <printf+0x195>
    20be:	83 7d e8 73          	cmpl   $0x73,-0x18(%ebp)
    20c2:	75 46                	jne    210a <printf+0x12d>
    20c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    20c7:	8b 00                	mov    (%eax),%eax
    20c9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    20cc:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    20d0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    20d4:	75 27                	jne    20fd <printf+0x120>
    20d6:	c7 45 e4 6f 27 00 00 	movl   $0x276f,-0x1c(%ebp)
    20dd:	eb 1f                	jmp    20fe <printf+0x121>
    20df:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    20e2:	0f b6 00             	movzbl (%eax),%eax
    20e5:	0f be c0             	movsbl %al,%eax
    20e8:	89 44 24 04          	mov    %eax,0x4(%esp)
    20ec:	8b 45 08             	mov    0x8(%ebp),%eax
    20ef:	89 04 24             	mov    %eax,(%esp)
    20f2:	e8 0d fe ff ff       	call   1f04 <putc>
    20f7:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    20fb:	eb 01                	jmp    20fe <printf+0x121>
    20fd:	90                   	nop
    20fe:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2101:	0f b6 00             	movzbl (%eax),%eax
    2104:	84 c0                	test   %al,%al
    2106:	75 d7                	jne    20df <printf+0x102>
    2108:	eb 68                	jmp    2172 <printf+0x195>
    210a:	83 7d e8 63          	cmpl   $0x63,-0x18(%ebp)
    210e:	75 1d                	jne    212d <printf+0x150>
    2110:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2113:	8b 00                	mov    (%eax),%eax
    2115:	0f be c0             	movsbl %al,%eax
    2118:	89 44 24 04          	mov    %eax,0x4(%esp)
    211c:	8b 45 08             	mov    0x8(%ebp),%eax
    211f:	89 04 24             	mov    %eax,(%esp)
    2122:	e8 dd fd ff ff       	call   1f04 <putc>
    2127:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    212b:	eb 45                	jmp    2172 <printf+0x195>
    212d:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    2131:	75 17                	jne    214a <printf+0x16d>
    2133:	8b 45 e8             	mov    -0x18(%ebp),%eax
    2136:	0f be c0             	movsbl %al,%eax
    2139:	89 44 24 04          	mov    %eax,0x4(%esp)
    213d:	8b 45 08             	mov    0x8(%ebp),%eax
    2140:	89 04 24             	mov    %eax,(%esp)
    2143:	e8 bc fd ff ff       	call   1f04 <putc>
    2148:	eb 28                	jmp    2172 <printf+0x195>
    214a:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    2151:	00 
    2152:	8b 45 08             	mov    0x8(%ebp),%eax
    2155:	89 04 24             	mov    %eax,(%esp)
    2158:	e8 a7 fd ff ff       	call   1f04 <putc>
    215d:	8b 45 e8             	mov    -0x18(%ebp),%eax
    2160:	0f be c0             	movsbl %al,%eax
    2163:	89 44 24 04          	mov    %eax,0x4(%esp)
    2167:	8b 45 08             	mov    0x8(%ebp),%eax
    216a:	89 04 24             	mov    %eax,(%esp)
    216d:	e8 92 fd ff ff       	call   1f04 <putc>
    2172:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    2179:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    217d:	8b 55 0c             	mov    0xc(%ebp),%edx
    2180:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2183:	8d 04 02             	lea    (%edx,%eax,1),%eax
    2186:	0f b6 00             	movzbl (%eax),%eax
    2189:	84 c0                	test   %al,%al
    218b:	0f 85 6e fe ff ff    	jne    1fff <printf+0x22>
    2191:	c9                   	leave  
    2192:	c3                   	ret    
    2193:	90                   	nop

00002194 <free>:
    2194:	55                   	push   %ebp
    2195:	89 e5                	mov    %esp,%ebp
    2197:	83 ec 10             	sub    $0x10,%esp
    219a:	8b 45 08             	mov    0x8(%ebp),%eax
    219d:	83 e8 08             	sub    $0x8,%eax
    21a0:	89 45 f8             	mov    %eax,-0x8(%ebp)
    21a3:	a1 d4 27 00 00       	mov    0x27d4,%eax
    21a8:	89 45 fc             	mov    %eax,-0x4(%ebp)
    21ab:	eb 24                	jmp    21d1 <free+0x3d>
    21ad:	8b 45 fc             	mov    -0x4(%ebp),%eax
    21b0:	8b 00                	mov    (%eax),%eax
    21b2:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    21b5:	77 12                	ja     21c9 <free+0x35>
    21b7:	8b 45 f8             	mov    -0x8(%ebp),%eax
    21ba:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    21bd:	77 24                	ja     21e3 <free+0x4f>
    21bf:	8b 45 fc             	mov    -0x4(%ebp),%eax
    21c2:	8b 00                	mov    (%eax),%eax
    21c4:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    21c7:	77 1a                	ja     21e3 <free+0x4f>
    21c9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    21cc:	8b 00                	mov    (%eax),%eax
    21ce:	89 45 fc             	mov    %eax,-0x4(%ebp)
    21d1:	8b 45 f8             	mov    -0x8(%ebp),%eax
    21d4:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    21d7:	76 d4                	jbe    21ad <free+0x19>
    21d9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    21dc:	8b 00                	mov    (%eax),%eax
    21de:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    21e1:	76 ca                	jbe    21ad <free+0x19>
    21e3:	8b 45 f8             	mov    -0x8(%ebp),%eax
    21e6:	8b 40 04             	mov    0x4(%eax),%eax
    21e9:	c1 e0 03             	shl    $0x3,%eax
    21ec:	89 c2                	mov    %eax,%edx
    21ee:	03 55 f8             	add    -0x8(%ebp),%edx
    21f1:	8b 45 fc             	mov    -0x4(%ebp),%eax
    21f4:	8b 00                	mov    (%eax),%eax
    21f6:	39 c2                	cmp    %eax,%edx
    21f8:	75 24                	jne    221e <free+0x8a>
    21fa:	8b 45 f8             	mov    -0x8(%ebp),%eax
    21fd:	8b 50 04             	mov    0x4(%eax),%edx
    2200:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2203:	8b 00                	mov    (%eax),%eax
    2205:	8b 40 04             	mov    0x4(%eax),%eax
    2208:	01 c2                	add    %eax,%edx
    220a:	8b 45 f8             	mov    -0x8(%ebp),%eax
    220d:	89 50 04             	mov    %edx,0x4(%eax)
    2210:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2213:	8b 00                	mov    (%eax),%eax
    2215:	8b 10                	mov    (%eax),%edx
    2217:	8b 45 f8             	mov    -0x8(%ebp),%eax
    221a:	89 10                	mov    %edx,(%eax)
    221c:	eb 0a                	jmp    2228 <free+0x94>
    221e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2221:	8b 10                	mov    (%eax),%edx
    2223:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2226:	89 10                	mov    %edx,(%eax)
    2228:	8b 45 fc             	mov    -0x4(%ebp),%eax
    222b:	8b 40 04             	mov    0x4(%eax),%eax
    222e:	c1 e0 03             	shl    $0x3,%eax
    2231:	03 45 fc             	add    -0x4(%ebp),%eax
    2234:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    2237:	75 20                	jne    2259 <free+0xc5>
    2239:	8b 45 fc             	mov    -0x4(%ebp),%eax
    223c:	8b 50 04             	mov    0x4(%eax),%edx
    223f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2242:	8b 40 04             	mov    0x4(%eax),%eax
    2245:	01 c2                	add    %eax,%edx
    2247:	8b 45 fc             	mov    -0x4(%ebp),%eax
    224a:	89 50 04             	mov    %edx,0x4(%eax)
    224d:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2250:	8b 10                	mov    (%eax),%edx
    2252:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2255:	89 10                	mov    %edx,(%eax)
    2257:	eb 08                	jmp    2261 <free+0xcd>
    2259:	8b 45 fc             	mov    -0x4(%ebp),%eax
    225c:	8b 55 f8             	mov    -0x8(%ebp),%edx
    225f:	89 10                	mov    %edx,(%eax)
    2261:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2264:	a3 d4 27 00 00       	mov    %eax,0x27d4
    2269:	c9                   	leave  
    226a:	c3                   	ret    

0000226b <morecore>:
    226b:	55                   	push   %ebp
    226c:	89 e5                	mov    %esp,%ebp
    226e:	83 ec 28             	sub    $0x28,%esp
    2271:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    2278:	77 07                	ja     2281 <morecore+0x16>
    227a:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
    2281:	8b 45 08             	mov    0x8(%ebp),%eax
    2284:	c1 e0 03             	shl    $0x3,%eax
    2287:	89 04 24             	mov    %eax,(%esp)
    228a:	e8 35 fc ff ff       	call   1ec4 <sbrk>
    228f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    2292:	83 7d f0 ff          	cmpl   $0xffffffff,-0x10(%ebp)
    2296:	75 07                	jne    229f <morecore+0x34>
    2298:	b8 00 00 00 00       	mov    $0x0,%eax
    229d:	eb 22                	jmp    22c1 <morecore+0x56>
    229f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    22a2:	89 45 f4             	mov    %eax,-0xc(%ebp)
    22a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    22a8:	8b 55 08             	mov    0x8(%ebp),%edx
    22ab:	89 50 04             	mov    %edx,0x4(%eax)
    22ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
    22b1:	83 c0 08             	add    $0x8,%eax
    22b4:	89 04 24             	mov    %eax,(%esp)
    22b7:	e8 d8 fe ff ff       	call   2194 <free>
    22bc:	a1 d4 27 00 00       	mov    0x27d4,%eax
    22c1:	c9                   	leave  
    22c2:	c3                   	ret    

000022c3 <malloc>:
    22c3:	55                   	push   %ebp
    22c4:	89 e5                	mov    %esp,%ebp
    22c6:	83 ec 28             	sub    $0x28,%esp
    22c9:	8b 45 08             	mov    0x8(%ebp),%eax
    22cc:	83 c0 07             	add    $0x7,%eax
    22cf:	c1 e8 03             	shr    $0x3,%eax
    22d2:	83 c0 01             	add    $0x1,%eax
    22d5:	89 45 f4             	mov    %eax,-0xc(%ebp)
    22d8:	a1 d4 27 00 00       	mov    0x27d4,%eax
    22dd:	89 45 f0             	mov    %eax,-0x10(%ebp)
    22e0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    22e4:	75 23                	jne    2309 <malloc+0x46>
    22e6:	c7 45 f0 cc 27 00 00 	movl   $0x27cc,-0x10(%ebp)
    22ed:	8b 45 f0             	mov    -0x10(%ebp),%eax
    22f0:	a3 d4 27 00 00       	mov    %eax,0x27d4
    22f5:	a1 d4 27 00 00       	mov    0x27d4,%eax
    22fa:	a3 cc 27 00 00       	mov    %eax,0x27cc
    22ff:	c7 05 d0 27 00 00 00 	movl   $0x0,0x27d0
    2306:	00 00 00 
    2309:	8b 45 f0             	mov    -0x10(%ebp),%eax
    230c:	8b 00                	mov    (%eax),%eax
    230e:	89 45 ec             	mov    %eax,-0x14(%ebp)
    2311:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2314:	8b 40 04             	mov    0x4(%eax),%eax
    2317:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    231a:	72 4d                	jb     2369 <malloc+0xa6>
    231c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    231f:	8b 40 04             	mov    0x4(%eax),%eax
    2322:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    2325:	75 0c                	jne    2333 <malloc+0x70>
    2327:	8b 45 ec             	mov    -0x14(%ebp),%eax
    232a:	8b 10                	mov    (%eax),%edx
    232c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    232f:	89 10                	mov    %edx,(%eax)
    2331:	eb 26                	jmp    2359 <malloc+0x96>
    2333:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2336:	8b 40 04             	mov    0x4(%eax),%eax
    2339:	89 c2                	mov    %eax,%edx
    233b:	2b 55 f4             	sub    -0xc(%ebp),%edx
    233e:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2341:	89 50 04             	mov    %edx,0x4(%eax)
    2344:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2347:	8b 40 04             	mov    0x4(%eax),%eax
    234a:	c1 e0 03             	shl    $0x3,%eax
    234d:	01 45 ec             	add    %eax,-0x14(%ebp)
    2350:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2353:	8b 55 f4             	mov    -0xc(%ebp),%edx
    2356:	89 50 04             	mov    %edx,0x4(%eax)
    2359:	8b 45 f0             	mov    -0x10(%ebp),%eax
    235c:	a3 d4 27 00 00       	mov    %eax,0x27d4
    2361:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2364:	83 c0 08             	add    $0x8,%eax
    2367:	eb 38                	jmp    23a1 <malloc+0xde>
    2369:	a1 d4 27 00 00       	mov    0x27d4,%eax
    236e:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    2371:	75 1b                	jne    238e <malloc+0xcb>
    2373:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2376:	89 04 24             	mov    %eax,(%esp)
    2379:	e8 ed fe ff ff       	call   226b <morecore>
    237e:	89 45 ec             	mov    %eax,-0x14(%ebp)
    2381:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    2385:	75 07                	jne    238e <malloc+0xcb>
    2387:	b8 00 00 00 00       	mov    $0x0,%eax
    238c:	eb 13                	jmp    23a1 <malloc+0xde>
    238e:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2391:	89 45 f0             	mov    %eax,-0x10(%ebp)
    2394:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2397:	8b 00                	mov    (%eax),%eax
    2399:	89 45 ec             	mov    %eax,-0x14(%ebp)
    239c:	e9 70 ff ff ff       	jmp    2311 <malloc+0x4e>
    23a1:	c9                   	leave  
    23a2:	c3                   	ret    
    23a3:	90                   	nop

000023a4 <xchg>:
    23a4:	55                   	push   %ebp
    23a5:	89 e5                	mov    %esp,%ebp
    23a7:	83 ec 10             	sub    $0x10,%esp
    23aa:	8b 55 08             	mov    0x8(%ebp),%edx
    23ad:	8b 45 0c             	mov    0xc(%ebp),%eax
    23b0:	8b 4d 08             	mov    0x8(%ebp),%ecx
    23b3:	f0 87 02             	lock xchg %eax,(%edx)
    23b6:	89 45 fc             	mov    %eax,-0x4(%ebp)
    23b9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    23bc:	c9                   	leave  
    23bd:	c3                   	ret    

000023be <lock_init>:
    23be:	55                   	push   %ebp
    23bf:	89 e5                	mov    %esp,%ebp
    23c1:	8b 45 08             	mov    0x8(%ebp),%eax
    23c4:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    23ca:	5d                   	pop    %ebp
    23cb:	c3                   	ret    

000023cc <lock_acquire>:
    23cc:	55                   	push   %ebp
    23cd:	89 e5                	mov    %esp,%ebp
    23cf:	83 ec 08             	sub    $0x8,%esp
    23d2:	8b 45 08             	mov    0x8(%ebp),%eax
    23d5:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    23dc:	00 
    23dd:	89 04 24             	mov    %eax,(%esp)
    23e0:	e8 bf ff ff ff       	call   23a4 <xchg>
    23e5:	85 c0                	test   %eax,%eax
    23e7:	75 e9                	jne    23d2 <lock_acquire+0x6>
    23e9:	c9                   	leave  
    23ea:	c3                   	ret    

000023eb <lock_release>:
    23eb:	55                   	push   %ebp
    23ec:	89 e5                	mov    %esp,%ebp
    23ee:	83 ec 08             	sub    $0x8,%esp
    23f1:	8b 45 08             	mov    0x8(%ebp),%eax
    23f4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    23fb:	00 
    23fc:	89 04 24             	mov    %eax,(%esp)
    23ff:	e8 a0 ff ff ff       	call   23a4 <xchg>
    2404:	c9                   	leave  
    2405:	c3                   	ret    

00002406 <thread_create>:
    2406:	55                   	push   %ebp
    2407:	89 e5                	mov    %esp,%ebp
    2409:	83 ec 28             	sub    $0x28,%esp
    240c:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    2413:	e8 ab fe ff ff       	call   22c3 <malloc>
    2418:	89 45 f0             	mov    %eax,-0x10(%ebp)
    241b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    241e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    2421:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2424:	25 ff 0f 00 00       	and    $0xfff,%eax
    2429:	85 c0                	test   %eax,%eax
    242b:	74 15                	je     2442 <thread_create+0x3c>
    242d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2430:	89 c2                	mov    %eax,%edx
    2432:	81 e2 ff 0f 00 00    	and    $0xfff,%edx
    2438:	b8 00 10 00 00       	mov    $0x1000,%eax
    243d:	29 d0                	sub    %edx,%eax
    243f:	01 45 f0             	add    %eax,-0x10(%ebp)
    2442:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2446:	75 1b                	jne    2463 <thread_create+0x5d>
    2448:	c7 44 24 04 76 27 00 	movl   $0x2776,0x4(%esp)
    244f:	00 
    2450:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2457:	e8 81 fb ff ff       	call   1fdd <printf>
    245c:	b8 00 00 00 00       	mov    $0x0,%eax
    2461:	eb 6f                	jmp    24d2 <thread_create+0xcc>
    2463:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    2466:	8b 55 08             	mov    0x8(%ebp),%edx
    2469:	8b 45 f0             	mov    -0x10(%ebp),%eax
    246c:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    2470:	89 54 24 08          	mov    %edx,0x8(%esp)
    2474:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    247b:	00 
    247c:	89 04 24             	mov    %eax,(%esp)
    247f:	e8 58 fa ff ff       	call   1edc <clone>
    2484:	89 45 ec             	mov    %eax,-0x14(%ebp)
    2487:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    248b:	79 1b                	jns    24a8 <thread_create+0xa2>
    248d:	c7 44 24 04 84 27 00 	movl   $0x2784,0x4(%esp)
    2494:	00 
    2495:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    249c:	e8 3c fb ff ff       	call   1fdd <printf>
    24a1:	b8 00 00 00 00       	mov    $0x0,%eax
    24a6:	eb 2a                	jmp    24d2 <thread_create+0xcc>
    24a8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    24ac:	7e 05                	jle    24b3 <thread_create+0xad>
    24ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
    24b1:	eb 1f                	jmp    24d2 <thread_create+0xcc>
    24b3:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    24b7:	75 14                	jne    24cd <thread_create+0xc7>
    24b9:	c7 44 24 04 91 27 00 	movl   $0x2791,0x4(%esp)
    24c0:	00 
    24c1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    24c8:	e8 10 fb ff ff       	call   1fdd <printf>
    24cd:	b8 00 00 00 00       	mov    $0x0,%eax
    24d2:	c9                   	leave  
    24d3:	c3                   	ret    

000024d4 <random>:
    24d4:	55                   	push   %ebp
    24d5:	89 e5                	mov    %esp,%ebp
    24d7:	a1 bc 27 00 00       	mov    0x27bc,%eax
    24dc:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    24e2:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
    24e7:	a3 bc 27 00 00       	mov    %eax,0x27bc
    24ec:	a1 bc 27 00 00       	mov    0x27bc,%eax
    24f1:	8b 4d 08             	mov    0x8(%ebp),%ecx
    24f4:	ba 00 00 00 00       	mov    $0x0,%edx
    24f9:	f7 f1                	div    %ecx
    24fb:	89 d0                	mov    %edx,%eax
    24fd:	5d                   	pop    %ebp
    24fe:	c3                   	ret    
    24ff:	90                   	nop

00002500 <init_q>:
    2500:	55                   	push   %ebp
    2501:	89 e5                	mov    %esp,%ebp
    2503:	8b 45 08             	mov    0x8(%ebp),%eax
    2506:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    250c:	8b 45 08             	mov    0x8(%ebp),%eax
    250f:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    2516:	8b 45 08             	mov    0x8(%ebp),%eax
    2519:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
    2520:	5d                   	pop    %ebp
    2521:	c3                   	ret    

00002522 <add_q>:
    2522:	55                   	push   %ebp
    2523:	89 e5                	mov    %esp,%ebp
    2525:	83 ec 28             	sub    $0x28,%esp
    2528:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    252f:	e8 8f fd ff ff       	call   22c3 <malloc>
    2534:	89 45 f4             	mov    %eax,-0xc(%ebp)
    2537:	8b 45 f4             	mov    -0xc(%ebp),%eax
    253a:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    2541:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2544:	8b 55 0c             	mov    0xc(%ebp),%edx
    2547:	89 10                	mov    %edx,(%eax)
    2549:	8b 45 08             	mov    0x8(%ebp),%eax
    254c:	8b 40 04             	mov    0x4(%eax),%eax
    254f:	85 c0                	test   %eax,%eax
    2551:	75 0b                	jne    255e <add_q+0x3c>
    2553:	8b 45 08             	mov    0x8(%ebp),%eax
    2556:	8b 55 f4             	mov    -0xc(%ebp),%edx
    2559:	89 50 04             	mov    %edx,0x4(%eax)
    255c:	eb 0c                	jmp    256a <add_q+0x48>
    255e:	8b 45 08             	mov    0x8(%ebp),%eax
    2561:	8b 40 08             	mov    0x8(%eax),%eax
    2564:	8b 55 f4             	mov    -0xc(%ebp),%edx
    2567:	89 50 04             	mov    %edx,0x4(%eax)
    256a:	8b 45 08             	mov    0x8(%ebp),%eax
    256d:	8b 55 f4             	mov    -0xc(%ebp),%edx
    2570:	89 50 08             	mov    %edx,0x8(%eax)
    2573:	8b 45 08             	mov    0x8(%ebp),%eax
    2576:	8b 00                	mov    (%eax),%eax
    2578:	8d 50 01             	lea    0x1(%eax),%edx
    257b:	8b 45 08             	mov    0x8(%ebp),%eax
    257e:	89 10                	mov    %edx,(%eax)
    2580:	c9                   	leave  
    2581:	c3                   	ret    

00002582 <empty_q>:
    2582:	55                   	push   %ebp
    2583:	89 e5                	mov    %esp,%ebp
    2585:	8b 45 08             	mov    0x8(%ebp),%eax
    2588:	8b 00                	mov    (%eax),%eax
    258a:	85 c0                	test   %eax,%eax
    258c:	75 07                	jne    2595 <empty_q+0x13>
    258e:	b8 01 00 00 00       	mov    $0x1,%eax
    2593:	eb 05                	jmp    259a <empty_q+0x18>
    2595:	b8 00 00 00 00       	mov    $0x0,%eax
    259a:	5d                   	pop    %ebp
    259b:	c3                   	ret    

0000259c <pop_q>:
    259c:	55                   	push   %ebp
    259d:	89 e5                	mov    %esp,%ebp
    259f:	83 ec 28             	sub    $0x28,%esp
    25a2:	8b 45 08             	mov    0x8(%ebp),%eax
    25a5:	89 04 24             	mov    %eax,(%esp)
    25a8:	e8 d5 ff ff ff       	call   2582 <empty_q>
    25ad:	85 c0                	test   %eax,%eax
    25af:	75 5d                	jne    260e <pop_q+0x72>
    25b1:	8b 45 08             	mov    0x8(%ebp),%eax
    25b4:	8b 40 04             	mov    0x4(%eax),%eax
    25b7:	8b 00                	mov    (%eax),%eax
    25b9:	89 45 f0             	mov    %eax,-0x10(%ebp)
    25bc:	8b 45 08             	mov    0x8(%ebp),%eax
    25bf:	8b 40 04             	mov    0x4(%eax),%eax
    25c2:	89 45 f4             	mov    %eax,-0xc(%ebp)
    25c5:	8b 45 08             	mov    0x8(%ebp),%eax
    25c8:	8b 40 04             	mov    0x4(%eax),%eax
    25cb:	8b 50 04             	mov    0x4(%eax),%edx
    25ce:	8b 45 08             	mov    0x8(%ebp),%eax
    25d1:	89 50 04             	mov    %edx,0x4(%eax)
    25d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    25d7:	89 04 24             	mov    %eax,(%esp)
    25da:	e8 b5 fb ff ff       	call   2194 <free>
    25df:	8b 45 08             	mov    0x8(%ebp),%eax
    25e2:	8b 00                	mov    (%eax),%eax
    25e4:	8d 50 ff             	lea    -0x1(%eax),%edx
    25e7:	8b 45 08             	mov    0x8(%ebp),%eax
    25ea:	89 10                	mov    %edx,(%eax)
    25ec:	8b 45 08             	mov    0x8(%ebp),%eax
    25ef:	8b 00                	mov    (%eax),%eax
    25f1:	85 c0                	test   %eax,%eax
    25f3:	75 14                	jne    2609 <pop_q+0x6d>
    25f5:	8b 45 08             	mov    0x8(%ebp),%eax
    25f8:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    25ff:	8b 45 08             	mov    0x8(%ebp),%eax
    2602:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
    2609:	8b 45 f0             	mov    -0x10(%ebp),%eax
    260c:	eb 05                	jmp    2613 <pop_q+0x77>
    260e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    2613:	c9                   	leave  
    2614:	c3                   	ret    
