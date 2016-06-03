
_frisbee:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:
    1000:	8d 4c 24 04          	lea    0x4(%esp),%ecx
    1004:	83 e4 f0             	and    $0xfffffff0,%esp
    1007:	ff 71 fc             	pushl  -0x4(%ecx)
    100a:	55                   	push   %ebp
    100b:	89 e5                	mov    %esp,%ebp
    100d:	57                   	push   %edi
    100e:	56                   	push   %esi
    100f:	53                   	push   %ebx
    1010:	51                   	push   %ecx
    1011:	83 ec 58             	sub    $0x58,%esp
    1014:	89 cb                	mov    %ecx,%ebx
    1016:	83 3b 03             	cmpl   $0x3,(%ebx)
    1019:	74 19                	je     1034 <main+0x34>
    101b:	c7 44 24 04 a8 1e 00 	movl   $0x1ea8,0x4(%esp)
    1022:	00 
    1023:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    102a:	e8 3e 08 00 00       	call   186d <printf>
    102f:	e8 98 06 00 00       	call   16cc <exit>
    1034:	8b 43 04             	mov    0x4(%ebx),%eax
    1037:	83 c0 04             	add    $0x4,%eax
    103a:	8b 00                	mov    (%eax),%eax
    103c:	89 04 24             	mov    %eax,(%esp)
    103f:	e8 f6 05 00 00       	call   163a <atoi>
    1044:	a3 e0 1f 00 00       	mov    %eax,0x1fe0
    1049:	8b 43 04             	mov    0x4(%ebx),%eax
    104c:	83 c0 08             	add    $0x8,%eax
    104f:	8b 00                	mov    (%eax),%eax
    1051:	89 04 24             	mov    %eax,(%esp)
    1054:	e8 e1 05 00 00       	call   163a <atoi>
    1059:	a3 e4 1f 00 00       	mov    %eax,0x1fe4
    105e:	8b 0d e0 1f 00 00    	mov    0x1fe0,%ecx
    1064:	8d 41 ff             	lea    -0x1(%ecx),%eax
    1067:	89 45 d0             	mov    %eax,-0x30(%ebp)
    106a:	89 c8                	mov    %ecx,%eax
    106c:	ba 00 00 00 00       	mov    $0x0,%edx
    1071:	89 c6                	mov    %eax,%esi
    1073:	83 e6 ff             	and    $0xffffffff,%esi
    1076:	89 d7                	mov    %edx,%edi
    1078:	83 e7 0f             	and    $0xf,%edi
    107b:	89 f0                	mov    %esi,%eax
    107d:	89 fa                	mov    %edi,%edx
    107f:	0f a4 c2 05          	shld   $0x5,%eax,%edx
    1083:	c1 e0 05             	shl    $0x5,%eax
    1086:	89 c3                	mov    %eax,%ebx
    1088:	80 e7 ff             	and    $0xff,%bh
    108b:	89 5d c0             	mov    %ebx,-0x40(%ebp)
    108e:	89 d3                	mov    %edx,%ebx
    1090:	83 e3 0f             	and    $0xf,%ebx
    1093:	89 5d c4             	mov    %ebx,-0x3c(%ebp)
    1096:	8b 45 c0             	mov    -0x40(%ebp),%eax
    1099:	8b 55 c4             	mov    -0x3c(%ebp),%edx
    109c:	89 c8                	mov    %ecx,%eax
    109e:	ba 00 00 00 00       	mov    $0x0,%edx
    10a3:	89 c3                	mov    %eax,%ebx
    10a5:	80 e7 ff             	and    $0xff,%bh
    10a8:	89 5d b8             	mov    %ebx,-0x48(%ebp)
    10ab:	89 d3                	mov    %edx,%ebx
    10ad:	83 e3 0f             	and    $0xf,%ebx
    10b0:	89 5d bc             	mov    %ebx,-0x44(%ebp)
    10b3:	8b 45 b8             	mov    -0x48(%ebp),%eax
    10b6:	8b 55 bc             	mov    -0x44(%ebp),%edx
    10b9:	0f a4 c2 05          	shld   $0x5,%eax,%edx
    10bd:	c1 e0 05             	shl    $0x5,%eax
    10c0:	89 c3                	mov    %eax,%ebx
    10c2:	80 e7 ff             	and    $0xff,%bh
    10c5:	89 5d b0             	mov    %ebx,-0x50(%ebp)
    10c8:	89 d3                	mov    %edx,%ebx
    10ca:	83 e3 0f             	and    $0xf,%ebx
    10cd:	89 5d b4             	mov    %ebx,-0x4c(%ebp)
    10d0:	8b 45 b0             	mov    -0x50(%ebp),%eax
    10d3:	8b 55 b4             	mov    -0x4c(%ebp),%edx
    10d6:	89 c8                	mov    %ecx,%eax
    10d8:	c1 e0 02             	shl    $0x2,%eax
    10db:	83 c0 0f             	add    $0xf,%eax
    10de:	83 c0 0f             	add    $0xf,%eax
    10e1:	c1 e8 04             	shr    $0x4,%eax
    10e4:	c1 e0 04             	shl    $0x4,%eax
    10e7:	29 c4                	sub    %eax,%esp
    10e9:	8d 44 24 0c          	lea    0xc(%esp),%eax
    10ed:	83 c0 0f             	add    $0xf,%eax
    10f0:	c1 e8 04             	shr    $0x4,%eax
    10f3:	c1 e0 04             	shl    $0x4,%eax
    10f6:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    10f9:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    1100:	e8 49 0b 00 00       	call   1c4e <lock_init>
    1105:	c7 05 04 22 00 00 00 	movl   $0x0,0x2204
    110c:	00 00 00 
    110f:	c7 45 dc 04 20 00 00 	movl   $0x2004,-0x24(%ebp)
    1116:	eb 0d                	jmp    1125 <main+0x125>
    1118:	8b 45 dc             	mov    -0x24(%ebp),%eax
    111b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    1121:	83 45 dc 08          	addl   $0x8,-0x24(%ebp)
    1125:	b8 04 22 00 00       	mov    $0x2204,%eax
    112a:	39 45 dc             	cmp    %eax,-0x24(%ebp)
    112d:	72 e9                	jb     1118 <main+0x118>
    112f:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
    1136:	eb 11                	jmp    1149 <main+0x149>
    1138:	8b 55 d8             	mov    -0x28(%ebp),%edx
    113b:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    113e:	c7 04 90 00 00 00 00 	movl   $0x0,(%eax,%edx,4)
    1145:	83 45 d8 01          	addl   $0x1,-0x28(%ebp)
    1149:	83 7d d8 3f          	cmpl   $0x3f,-0x28(%ebp)
    114d:	7e e9                	jle    1138 <main+0x138>
    114f:	c7 04 24 08 22 00 00 	movl   $0x2208,(%esp)
    1156:	e8 f3 0a 00 00       	call   1c4e <lock_init>
    115b:	c7 05 0c 22 00 00 00 	movl   $0x0,0x220c
    1162:	00 00 00 
    1165:	c7 05 10 22 00 00 00 	movl   $0x0,0x2210
    116c:	00 00 00 
    116f:	a1 e0 1f 00 00       	mov    0x1fe0,%eax
    1174:	89 44 24 08          	mov    %eax,0x8(%esp)
    1178:	c7 44 24 04 bd 1e 00 	movl   $0x1ebd,0x4(%esp)
    117f:	00 
    1180:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1187:	e8 e1 06 00 00       	call   186d <printf>
    118c:	a1 e4 1f 00 00       	mov    0x1fe4,%eax
    1191:	89 44 24 08          	mov    %eax,0x8(%esp)
    1195:	c7 44 24 04 d2 1e 00 	movl   $0x1ed2,0x4(%esp)
    119c:	00 
    119d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    11a4:	e8 c4 06 00 00       	call   186d <printf>
    11a9:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
    11b0:	eb 43                	jmp    11f5 <main+0x1f5>
    11b2:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    11b9:	00 
    11ba:	c7 04 24 a0 12 00 00 	movl   $0x12a0,(%esp)
    11c1:	e8 d0 0a 00 00       	call   1c96 <thread_create>
    11c6:	89 45 e0             	mov    %eax,-0x20(%ebp)
    11c9:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
    11cd:	75 16                	jne    11e5 <main+0x1e5>
    11cf:	c7 44 24 04 e6 1e 00 	movl   $0x1ee6,0x4(%esp)
    11d6:	00 
    11d7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    11de:	e8 8a 06 00 00       	call   186d <printf>
    11e3:	eb 0c                	jmp    11f1 <main+0x1f1>
    11e5:	8b 55 d8             	mov    -0x28(%ebp),%edx
    11e8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    11eb:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    11ee:	89 0c 90             	mov    %ecx,(%eax,%edx,4)
    11f1:	83 45 d8 01          	addl   $0x1,-0x28(%ebp)
    11f5:	a1 e0 1f 00 00       	mov    0x1fe0,%eax
    11fa:	39 45 d8             	cmp    %eax,-0x28(%ebp)
    11fd:	7c b3                	jl     11b2 <main+0x1b2>
    11ff:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
    1206:	eb 0e                	jmp    1216 <main+0x216>
    1208:	e8 c7 04 00 00       	call   16d4 <wait>
    120d:	83 f8 ff             	cmp    $0xffffffff,%eax
    1210:	74 10                	je     1222 <main+0x222>
    1212:	83 45 d8 01          	addl   $0x1,-0x28(%ebp)
    1216:	a1 e0 1f 00 00       	mov    0x1fe0,%eax
    121b:	39 45 d8             	cmp    %eax,-0x28(%ebp)
    121e:	7c e8                	jl     1208 <main+0x208>
    1220:	eb 01                	jmp    1223 <main+0x223>
    1222:	90                   	nop
    1223:	c7 45 dc 04 20 00 00 	movl   $0x2004,-0x24(%ebp)
    122a:	eb 2a                	jmp    1256 <main+0x256>
    122c:	8b 45 dc             	mov    -0x24(%ebp),%eax
    122f:	8b 00                	mov    (%eax),%eax
    1231:	85 c0                	test   %eax,%eax
    1233:	74 1d                	je     1252 <main+0x252>
    1235:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1238:	8b 00                	mov    (%eax),%eax
    123a:	89 44 24 08          	mov    %eax,0x8(%esp)
    123e:	c7 44 24 04 fc 1e 00 	movl   $0x1efc,0x4(%esp)
    1245:	00 
    1246:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    124d:	e8 1b 06 00 00       	call   186d <printf>
    1252:	83 45 dc 08          	addl   $0x8,-0x24(%ebp)
    1256:	b8 04 22 00 00       	mov    $0x2204,%eax
    125b:	39 45 dc             	cmp    %eax,-0x24(%ebp)
    125e:	72 cc                	jb     122c <main+0x22c>
    1260:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
    1267:	eb 28                	jmp    1291 <main+0x291>
    1269:	8b 55 d8             	mov    -0x28(%ebp),%edx
    126c:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    126f:	8b 04 90             	mov    (%eax,%edx,4),%eax
    1272:	85 c0                	test   %eax,%eax
    1274:	74 17                	je     128d <main+0x28d>
    1276:	8b 55 d8             	mov    -0x28(%ebp),%edx
    1279:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    127c:	8b 04 90             	mov    (%eax,%edx,4),%eax
    127f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    1282:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1285:	89 04 24             	mov    %eax,(%esp)
    1288:	e8 97 07 00 00       	call   1a24 <free>
    128d:	83 45 d8 01          	addl   $0x1,-0x28(%ebp)
    1291:	a1 e0 1f 00 00       	mov    0x1fe0,%eax
    1296:	39 45 d8             	cmp    %eax,-0x28(%ebp)
    1299:	7c ce                	jl     1269 <main+0x269>
    129b:	e8 2c 04 00 00       	call   16cc <exit>

000012a0 <pass_next>:
    12a0:	55                   	push   %ebp
    12a1:	89 e5                	mov    %esp,%ebp
    12a3:	83 ec 28             	sub    $0x28,%esp
    12a6:	e8 a1 04 00 00       	call   174c <getpid>
    12ab:	89 45 f4             	mov    %eax,-0xc(%ebp)
    12ae:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    12b5:	e8 a2 09 00 00       	call   1c5c <lock_acquire>
    12ba:	c7 45 f0 04 20 00 00 	movl   $0x2004,-0x10(%ebp)
    12c1:	eb 17                	jmp    12da <pass_next+0x3a>
    12c3:	8b 45 f0             	mov    -0x10(%ebp),%eax
    12c6:	8b 00                	mov    (%eax),%eax
    12c8:	85 c0                	test   %eax,%eax
    12ca:	75 0a                	jne    12d6 <pass_next+0x36>
    12cc:	8b 45 f0             	mov    -0x10(%ebp),%eax
    12cf:	8b 55 f4             	mov    -0xc(%ebp),%edx
    12d2:	89 10                	mov    %edx,(%eax)
    12d4:	eb 0e                	jmp    12e4 <pass_next+0x44>
    12d6:	83 45 f0 08          	addl   $0x8,-0x10(%ebp)
    12da:	b8 04 22 00 00       	mov    $0x2204,%eax
    12df:	39 45 f0             	cmp    %eax,-0x10(%ebp)
    12e2:	72 df                	jb     12c3 <pass_next+0x23>
    12e4:	a1 04 22 00 00       	mov    0x2204,%eax
    12e9:	83 c0 01             	add    $0x1,%eax
    12ec:	a3 04 22 00 00       	mov    %eax,0x2204
    12f1:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    12f8:	e8 7e 09 00 00       	call   1c7b <lock_release>
    12fd:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    1304:	e8 53 09 00 00       	call   1c5c <lock_acquire>
    1309:	8b 15 04 22 00 00    	mov    0x2204,%edx
    130f:	a1 e0 1f 00 00       	mov    0x1fe0,%eax
    1314:	39 c2                	cmp    %eax,%edx
    1316:	75 39                	jne    1351 <pass_next+0xb1>
    1318:	8b 45 f0             	mov    -0x10(%ebp),%eax
    131b:	8b 00                	mov    (%eax),%eax
    131d:	89 44 24 08          	mov    %eax,0x8(%esp)
    1321:	c7 44 24 04 24 1f 00 	movl   $0x1f24,0x4(%esp)
    1328:	00 
    1329:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1330:	e8 38 05 00 00       	call   186d <printf>
    1335:	a1 e8 1f 00 00       	mov    0x1fe8,%eax
    133a:	83 c0 01             	add    $0x1,%eax
    133d:	a3 e8 1f 00 00       	mov    %eax,0x1fe8
    1342:	90                   	nop
    1343:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    134a:	e8 2c 09 00 00       	call   1c7b <lock_release>
    134f:	eb 0e                	jmp    135f <pass_next+0xbf>
    1351:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    1358:	e8 1e 09 00 00       	call   1c7b <lock_release>
    135d:	eb 9e                	jmp    12fd <pass_next+0x5d>
    135f:	8b 15 e8 1f 00 00    	mov    0x1fe8,%edx
    1365:	a1 e0 1f 00 00       	mov    0x1fe0,%eax
    136a:	39 c2                	cmp    %eax,%edx
    136c:	75 f1                	jne    135f <pass_next+0xbf>
    136e:	c7 04 24 08 22 00 00 	movl   $0x2208,(%esp)
    1375:	e8 e2 08 00 00       	call   1c5c <lock_acquire>
    137a:	8b 15 0c 22 00 00    	mov    0x220c,%edx
    1380:	a1 e4 1f 00 00       	mov    0x1fe4,%eax
    1385:	39 c2                	cmp    %eax,%edx
    1387:	7e 39                	jle    13c2 <pass_next+0x122>
    1389:	c7 04 24 08 22 00 00 	movl   $0x2208,(%esp)
    1390:	e8 e6 08 00 00       	call   1c7b <lock_release>
    1395:	90                   	nop
    1396:	c7 04 24 08 22 00 00 	movl   $0x2208,(%esp)
    139d:	e8 d9 08 00 00       	call   1c7b <lock_release>
    13a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13a5:	89 44 24 08          	mov    %eax,0x8(%esp)
    13a9:	c7 44 24 04 70 1f 00 	movl   $0x1f70,0x4(%esp)
    13b0:	00 
    13b1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    13b8:	e8 b0 04 00 00       	call   186d <printf>
    13bd:	e8 b2 03 00 00       	call   1774 <texit>
    13c2:	a1 10 22 00 00       	mov    0x2210,%eax
    13c7:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    13ca:	75 1b                	jne    13e7 <pass_next+0x147>
    13cc:	c7 04 24 08 22 00 00 	movl   $0x2208,(%esp)
    13d3:	e8 a3 08 00 00       	call   1c7b <lock_release>
    13d8:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
    13df:	e8 78 03 00 00       	call   175c <sleep>
    13e4:	90                   	nop
    13e5:	eb 87                	jmp    136e <pass_next+0xce>
    13e7:	a1 0c 22 00 00       	mov    0x220c,%eax
    13ec:	8b 55 f4             	mov    -0xc(%ebp),%edx
    13ef:	89 54 24 0c          	mov    %edx,0xc(%esp)
    13f3:	89 44 24 08          	mov    %eax,0x8(%esp)
    13f7:	c7 44 24 04 3c 1f 00 	movl   $0x1f3c,0x4(%esp)
    13fe:	00 
    13ff:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1406:	e8 62 04 00 00       	call   186d <printf>
    140b:	a1 0c 22 00 00       	mov    0x220c,%eax
    1410:	83 c0 01             	add    $0x1,%eax
    1413:	a3 0c 22 00 00       	mov    %eax,0x220c
    1418:	8b 45 f4             	mov    -0xc(%ebp),%eax
    141b:	a3 10 22 00 00       	mov    %eax,0x2210
    1420:	c7 04 24 08 22 00 00 	movl   $0x2208,(%esp)
    1427:	e8 4f 08 00 00       	call   1c7b <lock_release>
    142c:	e9 3d ff ff ff       	jmp    136e <pass_next+0xce>

00001431 <lookup>:
    1431:	55                   	push   %ebp
    1432:	89 e5                	mov    %esp,%ebp
    1434:	83 ec 10             	sub    $0x10,%esp
    1437:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    143e:	c7 45 fc 04 20 00 00 	movl   $0x2004,-0x4(%ebp)
    1445:	eb 11                	jmp    1458 <lookup+0x27>
    1447:	8b 45 fc             	mov    -0x4(%ebp),%eax
    144a:	8b 00                	mov    (%eax),%eax
    144c:	85 c0                	test   %eax,%eax
    144e:	74 04                	je     1454 <lookup+0x23>
    1450:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    1454:	83 45 fc 08          	addl   $0x8,-0x4(%ebp)
    1458:	b8 04 22 00 00       	mov    $0x2204,%eax
    145d:	39 45 fc             	cmp    %eax,-0x4(%ebp)
    1460:	72 e5                	jb     1447 <lookup+0x16>
    1462:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1465:	c9                   	leave  
    1466:	c3                   	ret    
    1467:	90                   	nop

00001468 <stosb>:
    1468:	55                   	push   %ebp
    1469:	89 e5                	mov    %esp,%ebp
    146b:	57                   	push   %edi
    146c:	53                   	push   %ebx
    146d:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1470:	8b 55 10             	mov    0x10(%ebp),%edx
    1473:	8b 45 0c             	mov    0xc(%ebp),%eax
    1476:	89 cb                	mov    %ecx,%ebx
    1478:	89 df                	mov    %ebx,%edi
    147a:	89 d1                	mov    %edx,%ecx
    147c:	fc                   	cld    
    147d:	f3 aa                	rep stos %al,%es:(%edi)
    147f:	89 ca                	mov    %ecx,%edx
    1481:	89 fb                	mov    %edi,%ebx
    1483:	89 5d 08             	mov    %ebx,0x8(%ebp)
    1486:	89 55 10             	mov    %edx,0x10(%ebp)
    1489:	5b                   	pop    %ebx
    148a:	5f                   	pop    %edi
    148b:	5d                   	pop    %ebp
    148c:	c3                   	ret    

0000148d <strcpy>:
    148d:	55                   	push   %ebp
    148e:	89 e5                	mov    %esp,%ebp
    1490:	83 ec 10             	sub    $0x10,%esp
    1493:	8b 45 08             	mov    0x8(%ebp),%eax
    1496:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1499:	8b 45 0c             	mov    0xc(%ebp),%eax
    149c:	0f b6 10             	movzbl (%eax),%edx
    149f:	8b 45 08             	mov    0x8(%ebp),%eax
    14a2:	88 10                	mov    %dl,(%eax)
    14a4:	8b 45 08             	mov    0x8(%ebp),%eax
    14a7:	0f b6 00             	movzbl (%eax),%eax
    14aa:	84 c0                	test   %al,%al
    14ac:	0f 95 c0             	setne  %al
    14af:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    14b3:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    14b7:	84 c0                	test   %al,%al
    14b9:	75 de                	jne    1499 <strcpy+0xc>
    14bb:	8b 45 fc             	mov    -0x4(%ebp),%eax
    14be:	c9                   	leave  
    14bf:	c3                   	ret    

000014c0 <strcmp>:
    14c0:	55                   	push   %ebp
    14c1:	89 e5                	mov    %esp,%ebp
    14c3:	eb 08                	jmp    14cd <strcmp+0xd>
    14c5:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    14c9:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    14cd:	8b 45 08             	mov    0x8(%ebp),%eax
    14d0:	0f b6 00             	movzbl (%eax),%eax
    14d3:	84 c0                	test   %al,%al
    14d5:	74 10                	je     14e7 <strcmp+0x27>
    14d7:	8b 45 08             	mov    0x8(%ebp),%eax
    14da:	0f b6 10             	movzbl (%eax),%edx
    14dd:	8b 45 0c             	mov    0xc(%ebp),%eax
    14e0:	0f b6 00             	movzbl (%eax),%eax
    14e3:	38 c2                	cmp    %al,%dl
    14e5:	74 de                	je     14c5 <strcmp+0x5>
    14e7:	8b 45 08             	mov    0x8(%ebp),%eax
    14ea:	0f b6 00             	movzbl (%eax),%eax
    14ed:	0f b6 d0             	movzbl %al,%edx
    14f0:	8b 45 0c             	mov    0xc(%ebp),%eax
    14f3:	0f b6 00             	movzbl (%eax),%eax
    14f6:	0f b6 c0             	movzbl %al,%eax
    14f9:	89 d1                	mov    %edx,%ecx
    14fb:	29 c1                	sub    %eax,%ecx
    14fd:	89 c8                	mov    %ecx,%eax
    14ff:	5d                   	pop    %ebp
    1500:	c3                   	ret    

00001501 <strlen>:
    1501:	55                   	push   %ebp
    1502:	89 e5                	mov    %esp,%ebp
    1504:	83 ec 10             	sub    $0x10,%esp
    1507:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    150e:	eb 04                	jmp    1514 <strlen+0x13>
    1510:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    1514:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1517:	03 45 08             	add    0x8(%ebp),%eax
    151a:	0f b6 00             	movzbl (%eax),%eax
    151d:	84 c0                	test   %al,%al
    151f:	75 ef                	jne    1510 <strlen+0xf>
    1521:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1524:	c9                   	leave  
    1525:	c3                   	ret    

00001526 <memset>:
    1526:	55                   	push   %ebp
    1527:	89 e5                	mov    %esp,%ebp
    1529:	83 ec 0c             	sub    $0xc,%esp
    152c:	8b 45 10             	mov    0x10(%ebp),%eax
    152f:	89 44 24 08          	mov    %eax,0x8(%esp)
    1533:	8b 45 0c             	mov    0xc(%ebp),%eax
    1536:	89 44 24 04          	mov    %eax,0x4(%esp)
    153a:	8b 45 08             	mov    0x8(%ebp),%eax
    153d:	89 04 24             	mov    %eax,(%esp)
    1540:	e8 23 ff ff ff       	call   1468 <stosb>
    1545:	8b 45 08             	mov    0x8(%ebp),%eax
    1548:	c9                   	leave  
    1549:	c3                   	ret    

0000154a <strchr>:
    154a:	55                   	push   %ebp
    154b:	89 e5                	mov    %esp,%ebp
    154d:	83 ec 04             	sub    $0x4,%esp
    1550:	8b 45 0c             	mov    0xc(%ebp),%eax
    1553:	88 45 fc             	mov    %al,-0x4(%ebp)
    1556:	eb 14                	jmp    156c <strchr+0x22>
    1558:	8b 45 08             	mov    0x8(%ebp),%eax
    155b:	0f b6 00             	movzbl (%eax),%eax
    155e:	3a 45 fc             	cmp    -0x4(%ebp),%al
    1561:	75 05                	jne    1568 <strchr+0x1e>
    1563:	8b 45 08             	mov    0x8(%ebp),%eax
    1566:	eb 13                	jmp    157b <strchr+0x31>
    1568:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    156c:	8b 45 08             	mov    0x8(%ebp),%eax
    156f:	0f b6 00             	movzbl (%eax),%eax
    1572:	84 c0                	test   %al,%al
    1574:	75 e2                	jne    1558 <strchr+0xe>
    1576:	b8 00 00 00 00       	mov    $0x0,%eax
    157b:	c9                   	leave  
    157c:	c3                   	ret    

0000157d <gets>:
    157d:	55                   	push   %ebp
    157e:	89 e5                	mov    %esp,%ebp
    1580:	83 ec 28             	sub    $0x28,%esp
    1583:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    158a:	eb 44                	jmp    15d0 <gets+0x53>
    158c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1593:	00 
    1594:	8d 45 ef             	lea    -0x11(%ebp),%eax
    1597:	89 44 24 04          	mov    %eax,0x4(%esp)
    159b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    15a2:	e8 3d 01 00 00       	call   16e4 <read>
    15a7:	89 45 f4             	mov    %eax,-0xc(%ebp)
    15aa:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    15ae:	7e 2d                	jle    15dd <gets+0x60>
    15b0:	8b 45 f0             	mov    -0x10(%ebp),%eax
    15b3:	03 45 08             	add    0x8(%ebp),%eax
    15b6:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
    15ba:	88 10                	mov    %dl,(%eax)
    15bc:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    15c0:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    15c4:	3c 0a                	cmp    $0xa,%al
    15c6:	74 16                	je     15de <gets+0x61>
    15c8:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    15cc:	3c 0d                	cmp    $0xd,%al
    15ce:	74 0e                	je     15de <gets+0x61>
    15d0:	8b 45 f0             	mov    -0x10(%ebp),%eax
    15d3:	83 c0 01             	add    $0x1,%eax
    15d6:	3b 45 0c             	cmp    0xc(%ebp),%eax
    15d9:	7c b1                	jl     158c <gets+0xf>
    15db:	eb 01                	jmp    15de <gets+0x61>
    15dd:	90                   	nop
    15de:	8b 45 f0             	mov    -0x10(%ebp),%eax
    15e1:	03 45 08             	add    0x8(%ebp),%eax
    15e4:	c6 00 00             	movb   $0x0,(%eax)
    15e7:	8b 45 08             	mov    0x8(%ebp),%eax
    15ea:	c9                   	leave  
    15eb:	c3                   	ret    

000015ec <stat>:
    15ec:	55                   	push   %ebp
    15ed:	89 e5                	mov    %esp,%ebp
    15ef:	83 ec 28             	sub    $0x28,%esp
    15f2:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    15f9:	00 
    15fa:	8b 45 08             	mov    0x8(%ebp),%eax
    15fd:	89 04 24             	mov    %eax,(%esp)
    1600:	e8 07 01 00 00       	call   170c <open>
    1605:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1608:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    160c:	79 07                	jns    1615 <stat+0x29>
    160e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1613:	eb 23                	jmp    1638 <stat+0x4c>
    1615:	8b 45 0c             	mov    0xc(%ebp),%eax
    1618:	89 44 24 04          	mov    %eax,0x4(%esp)
    161c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    161f:	89 04 24             	mov    %eax,(%esp)
    1622:	e8 fd 00 00 00       	call   1724 <fstat>
    1627:	89 45 f4             	mov    %eax,-0xc(%ebp)
    162a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    162d:	89 04 24             	mov    %eax,(%esp)
    1630:	e8 bf 00 00 00       	call   16f4 <close>
    1635:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1638:	c9                   	leave  
    1639:	c3                   	ret    

0000163a <atoi>:
    163a:	55                   	push   %ebp
    163b:	89 e5                	mov    %esp,%ebp
    163d:	83 ec 10             	sub    $0x10,%esp
    1640:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    1647:	eb 24                	jmp    166d <atoi+0x33>
    1649:	8b 55 fc             	mov    -0x4(%ebp),%edx
    164c:	89 d0                	mov    %edx,%eax
    164e:	c1 e0 02             	shl    $0x2,%eax
    1651:	01 d0                	add    %edx,%eax
    1653:	01 c0                	add    %eax,%eax
    1655:	89 c2                	mov    %eax,%edx
    1657:	8b 45 08             	mov    0x8(%ebp),%eax
    165a:	0f b6 00             	movzbl (%eax),%eax
    165d:	0f be c0             	movsbl %al,%eax
    1660:	8d 04 02             	lea    (%edx,%eax,1),%eax
    1663:	83 e8 30             	sub    $0x30,%eax
    1666:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1669:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    166d:	8b 45 08             	mov    0x8(%ebp),%eax
    1670:	0f b6 00             	movzbl (%eax),%eax
    1673:	3c 2f                	cmp    $0x2f,%al
    1675:	7e 0a                	jle    1681 <atoi+0x47>
    1677:	8b 45 08             	mov    0x8(%ebp),%eax
    167a:	0f b6 00             	movzbl (%eax),%eax
    167d:	3c 39                	cmp    $0x39,%al
    167f:	7e c8                	jle    1649 <atoi+0xf>
    1681:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1684:	c9                   	leave  
    1685:	c3                   	ret    

00001686 <memmove>:
    1686:	55                   	push   %ebp
    1687:	89 e5                	mov    %esp,%ebp
    1689:	83 ec 10             	sub    $0x10,%esp
    168c:	8b 45 08             	mov    0x8(%ebp),%eax
    168f:	89 45 f8             	mov    %eax,-0x8(%ebp)
    1692:	8b 45 0c             	mov    0xc(%ebp),%eax
    1695:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1698:	eb 13                	jmp    16ad <memmove+0x27>
    169a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    169d:	0f b6 10             	movzbl (%eax),%edx
    16a0:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16a3:	88 10                	mov    %dl,(%eax)
    16a5:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    16a9:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    16ad:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    16b1:	0f 9f c0             	setg   %al
    16b4:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    16b8:	84 c0                	test   %al,%al
    16ba:	75 de                	jne    169a <memmove+0x14>
    16bc:	8b 45 08             	mov    0x8(%ebp),%eax
    16bf:	c9                   	leave  
    16c0:	c3                   	ret    
    16c1:	90                   	nop
    16c2:	90                   	nop
    16c3:	90                   	nop

000016c4 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    16c4:	b8 01 00 00 00       	mov    $0x1,%eax
    16c9:	cd 40                	int    $0x40
    16cb:	c3                   	ret    

000016cc <exit>:
SYSCALL(exit)
    16cc:	b8 02 00 00 00       	mov    $0x2,%eax
    16d1:	cd 40                	int    $0x40
    16d3:	c3                   	ret    

000016d4 <wait>:
SYSCALL(wait)
    16d4:	b8 03 00 00 00       	mov    $0x3,%eax
    16d9:	cd 40                	int    $0x40
    16db:	c3                   	ret    

000016dc <pipe>:
SYSCALL(pipe)
    16dc:	b8 04 00 00 00       	mov    $0x4,%eax
    16e1:	cd 40                	int    $0x40
    16e3:	c3                   	ret    

000016e4 <read>:
SYSCALL(read)
    16e4:	b8 05 00 00 00       	mov    $0x5,%eax
    16e9:	cd 40                	int    $0x40
    16eb:	c3                   	ret    

000016ec <write>:
SYSCALL(write)
    16ec:	b8 10 00 00 00       	mov    $0x10,%eax
    16f1:	cd 40                	int    $0x40
    16f3:	c3                   	ret    

000016f4 <close>:
SYSCALL(close)
    16f4:	b8 15 00 00 00       	mov    $0x15,%eax
    16f9:	cd 40                	int    $0x40
    16fb:	c3                   	ret    

000016fc <kill>:
SYSCALL(kill)
    16fc:	b8 06 00 00 00       	mov    $0x6,%eax
    1701:	cd 40                	int    $0x40
    1703:	c3                   	ret    

00001704 <exec>:
SYSCALL(exec)
    1704:	b8 07 00 00 00       	mov    $0x7,%eax
    1709:	cd 40                	int    $0x40
    170b:	c3                   	ret    

0000170c <open>:
SYSCALL(open)
    170c:	b8 0f 00 00 00       	mov    $0xf,%eax
    1711:	cd 40                	int    $0x40
    1713:	c3                   	ret    

00001714 <mknod>:
SYSCALL(mknod)
    1714:	b8 11 00 00 00       	mov    $0x11,%eax
    1719:	cd 40                	int    $0x40
    171b:	c3                   	ret    

0000171c <unlink>:
SYSCALL(unlink)
    171c:	b8 12 00 00 00       	mov    $0x12,%eax
    1721:	cd 40                	int    $0x40
    1723:	c3                   	ret    

00001724 <fstat>:
SYSCALL(fstat)
    1724:	b8 08 00 00 00       	mov    $0x8,%eax
    1729:	cd 40                	int    $0x40
    172b:	c3                   	ret    

0000172c <link>:
SYSCALL(link)
    172c:	b8 13 00 00 00       	mov    $0x13,%eax
    1731:	cd 40                	int    $0x40
    1733:	c3                   	ret    

00001734 <mkdir>:
SYSCALL(mkdir)
    1734:	b8 14 00 00 00       	mov    $0x14,%eax
    1739:	cd 40                	int    $0x40
    173b:	c3                   	ret    

0000173c <chdir>:
SYSCALL(chdir)
    173c:	b8 09 00 00 00       	mov    $0x9,%eax
    1741:	cd 40                	int    $0x40
    1743:	c3                   	ret    

00001744 <dup>:
SYSCALL(dup)
    1744:	b8 0a 00 00 00       	mov    $0xa,%eax
    1749:	cd 40                	int    $0x40
    174b:	c3                   	ret    

0000174c <getpid>:
SYSCALL(getpid)
    174c:	b8 0b 00 00 00       	mov    $0xb,%eax
    1751:	cd 40                	int    $0x40
    1753:	c3                   	ret    

00001754 <sbrk>:
SYSCALL(sbrk)
    1754:	b8 0c 00 00 00       	mov    $0xc,%eax
    1759:	cd 40                	int    $0x40
    175b:	c3                   	ret    

0000175c <sleep>:
SYSCALL(sleep)
    175c:	b8 0d 00 00 00       	mov    $0xd,%eax
    1761:	cd 40                	int    $0x40
    1763:	c3                   	ret    

00001764 <uptime>:
SYSCALL(uptime)
    1764:	b8 0e 00 00 00       	mov    $0xe,%eax
    1769:	cd 40                	int    $0x40
    176b:	c3                   	ret    

0000176c <clone>:
SYSCALL(clone)
    176c:	b8 16 00 00 00       	mov    $0x16,%eax
    1771:	cd 40                	int    $0x40
    1773:	c3                   	ret    

00001774 <texit>:
SYSCALL(texit)
    1774:	b8 17 00 00 00       	mov    $0x17,%eax
    1779:	cd 40                	int    $0x40
    177b:	c3                   	ret    

0000177c <tsleep>:
SYSCALL(tsleep)
    177c:	b8 18 00 00 00       	mov    $0x18,%eax
    1781:	cd 40                	int    $0x40
    1783:	c3                   	ret    

00001784 <twakeup>:
SYSCALL(twakeup)
    1784:	b8 19 00 00 00       	mov    $0x19,%eax
    1789:	cd 40                	int    $0x40
    178b:	c3                   	ret    

0000178c <thread_yield>:
SYSCALL(thread_yield)
    178c:	b8 1a 00 00 00       	mov    $0x1a,%eax
    1791:	cd 40                	int    $0x40
    1793:	c3                   	ret    

00001794 <putc>:
    1794:	55                   	push   %ebp
    1795:	89 e5                	mov    %esp,%ebp
    1797:	83 ec 28             	sub    $0x28,%esp
    179a:	8b 45 0c             	mov    0xc(%ebp),%eax
    179d:	88 45 f4             	mov    %al,-0xc(%ebp)
    17a0:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    17a7:	00 
    17a8:	8d 45 f4             	lea    -0xc(%ebp),%eax
    17ab:	89 44 24 04          	mov    %eax,0x4(%esp)
    17af:	8b 45 08             	mov    0x8(%ebp),%eax
    17b2:	89 04 24             	mov    %eax,(%esp)
    17b5:	e8 32 ff ff ff       	call   16ec <write>
    17ba:	c9                   	leave  
    17bb:	c3                   	ret    

000017bc <printint>:
    17bc:	55                   	push   %ebp
    17bd:	89 e5                	mov    %esp,%ebp
    17bf:	53                   	push   %ebx
    17c0:	83 ec 44             	sub    $0x44,%esp
    17c3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    17ca:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    17ce:	74 17                	je     17e7 <printint+0x2b>
    17d0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    17d4:	79 11                	jns    17e7 <printint+0x2b>
    17d6:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    17dd:	8b 45 0c             	mov    0xc(%ebp),%eax
    17e0:	f7 d8                	neg    %eax
    17e2:	89 45 f4             	mov    %eax,-0xc(%ebp)
    17e5:	eb 06                	jmp    17ed <printint+0x31>
    17e7:	8b 45 0c             	mov    0xc(%ebp),%eax
    17ea:	89 45 f4             	mov    %eax,-0xc(%ebp)
    17ed:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    17f4:	8b 4d ec             	mov    -0x14(%ebp),%ecx
    17f7:	8b 5d 10             	mov    0x10(%ebp),%ebx
    17fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17fd:	ba 00 00 00 00       	mov    $0x0,%edx
    1802:	f7 f3                	div    %ebx
    1804:	89 d0                	mov    %edx,%eax
    1806:	0f b6 80 bc 1f 00 00 	movzbl 0x1fbc(%eax),%eax
    180d:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
    1811:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1815:	8b 45 10             	mov    0x10(%ebp),%eax
    1818:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    181b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    181e:	ba 00 00 00 00       	mov    $0x0,%edx
    1823:	f7 75 d4             	divl   -0x2c(%ebp)
    1826:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1829:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    182d:	75 c5                	jne    17f4 <printint+0x38>
    182f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1833:	74 28                	je     185d <printint+0xa1>
    1835:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1838:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)
    183d:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1841:	eb 1a                	jmp    185d <printint+0xa1>
    1843:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1846:	0f b6 44 05 dc       	movzbl -0x24(%ebp,%eax,1),%eax
    184b:	0f be c0             	movsbl %al,%eax
    184e:	89 44 24 04          	mov    %eax,0x4(%esp)
    1852:	8b 45 08             	mov    0x8(%ebp),%eax
    1855:	89 04 24             	mov    %eax,(%esp)
    1858:	e8 37 ff ff ff       	call   1794 <putc>
    185d:	83 6d ec 01          	subl   $0x1,-0x14(%ebp)
    1861:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1865:	79 dc                	jns    1843 <printint+0x87>
    1867:	83 c4 44             	add    $0x44,%esp
    186a:	5b                   	pop    %ebx
    186b:	5d                   	pop    %ebp
    186c:	c3                   	ret    

0000186d <printf>:
    186d:	55                   	push   %ebp
    186e:	89 e5                	mov    %esp,%ebp
    1870:	83 ec 38             	sub    $0x38,%esp
    1873:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    187a:	8d 45 0c             	lea    0xc(%ebp),%eax
    187d:	83 c0 04             	add    $0x4,%eax
    1880:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1883:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    188a:	e9 7e 01 00 00       	jmp    1a0d <printf+0x1a0>
    188f:	8b 55 0c             	mov    0xc(%ebp),%edx
    1892:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1895:	8d 04 02             	lea    (%edx,%eax,1),%eax
    1898:	0f b6 00             	movzbl (%eax),%eax
    189b:	0f be c0             	movsbl %al,%eax
    189e:	25 ff 00 00 00       	and    $0xff,%eax
    18a3:	89 45 e8             	mov    %eax,-0x18(%ebp)
    18a6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    18aa:	75 2c                	jne    18d8 <printf+0x6b>
    18ac:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    18b0:	75 0c                	jne    18be <printf+0x51>
    18b2:	c7 45 f0 25 00 00 00 	movl   $0x25,-0x10(%ebp)
    18b9:	e9 4b 01 00 00       	jmp    1a09 <printf+0x19c>
    18be:	8b 45 e8             	mov    -0x18(%ebp),%eax
    18c1:	0f be c0             	movsbl %al,%eax
    18c4:	89 44 24 04          	mov    %eax,0x4(%esp)
    18c8:	8b 45 08             	mov    0x8(%ebp),%eax
    18cb:	89 04 24             	mov    %eax,(%esp)
    18ce:	e8 c1 fe ff ff       	call   1794 <putc>
    18d3:	e9 31 01 00 00       	jmp    1a09 <printf+0x19c>
    18d8:	83 7d f0 25          	cmpl   $0x25,-0x10(%ebp)
    18dc:	0f 85 27 01 00 00    	jne    1a09 <printf+0x19c>
    18e2:	83 7d e8 64          	cmpl   $0x64,-0x18(%ebp)
    18e6:	75 2d                	jne    1915 <printf+0xa8>
    18e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18eb:	8b 00                	mov    (%eax),%eax
    18ed:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    18f4:	00 
    18f5:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    18fc:	00 
    18fd:	89 44 24 04          	mov    %eax,0x4(%esp)
    1901:	8b 45 08             	mov    0x8(%ebp),%eax
    1904:	89 04 24             	mov    %eax,(%esp)
    1907:	e8 b0 fe ff ff       	call   17bc <printint>
    190c:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    1910:	e9 ed 00 00 00       	jmp    1a02 <printf+0x195>
    1915:	83 7d e8 78          	cmpl   $0x78,-0x18(%ebp)
    1919:	74 06                	je     1921 <printf+0xb4>
    191b:	83 7d e8 70          	cmpl   $0x70,-0x18(%ebp)
    191f:	75 2d                	jne    194e <printf+0xe1>
    1921:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1924:	8b 00                	mov    (%eax),%eax
    1926:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    192d:	00 
    192e:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    1935:	00 
    1936:	89 44 24 04          	mov    %eax,0x4(%esp)
    193a:	8b 45 08             	mov    0x8(%ebp),%eax
    193d:	89 04 24             	mov    %eax,(%esp)
    1940:	e8 77 fe ff ff       	call   17bc <printint>
    1945:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    1949:	e9 b4 00 00 00       	jmp    1a02 <printf+0x195>
    194e:	83 7d e8 73          	cmpl   $0x73,-0x18(%ebp)
    1952:	75 46                	jne    199a <printf+0x12d>
    1954:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1957:	8b 00                	mov    (%eax),%eax
    1959:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    195c:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    1960:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    1964:	75 27                	jne    198d <printf+0x120>
    1966:	c7 45 e4 87 1f 00 00 	movl   $0x1f87,-0x1c(%ebp)
    196d:	eb 1f                	jmp    198e <printf+0x121>
    196f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1972:	0f b6 00             	movzbl (%eax),%eax
    1975:	0f be c0             	movsbl %al,%eax
    1978:	89 44 24 04          	mov    %eax,0x4(%esp)
    197c:	8b 45 08             	mov    0x8(%ebp),%eax
    197f:	89 04 24             	mov    %eax,(%esp)
    1982:	e8 0d fe ff ff       	call   1794 <putc>
    1987:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    198b:	eb 01                	jmp    198e <printf+0x121>
    198d:	90                   	nop
    198e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1991:	0f b6 00             	movzbl (%eax),%eax
    1994:	84 c0                	test   %al,%al
    1996:	75 d7                	jne    196f <printf+0x102>
    1998:	eb 68                	jmp    1a02 <printf+0x195>
    199a:	83 7d e8 63          	cmpl   $0x63,-0x18(%ebp)
    199e:	75 1d                	jne    19bd <printf+0x150>
    19a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19a3:	8b 00                	mov    (%eax),%eax
    19a5:	0f be c0             	movsbl %al,%eax
    19a8:	89 44 24 04          	mov    %eax,0x4(%esp)
    19ac:	8b 45 08             	mov    0x8(%ebp),%eax
    19af:	89 04 24             	mov    %eax,(%esp)
    19b2:	e8 dd fd ff ff       	call   1794 <putc>
    19b7:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    19bb:	eb 45                	jmp    1a02 <printf+0x195>
    19bd:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    19c1:	75 17                	jne    19da <printf+0x16d>
    19c3:	8b 45 e8             	mov    -0x18(%ebp),%eax
    19c6:	0f be c0             	movsbl %al,%eax
    19c9:	89 44 24 04          	mov    %eax,0x4(%esp)
    19cd:	8b 45 08             	mov    0x8(%ebp),%eax
    19d0:	89 04 24             	mov    %eax,(%esp)
    19d3:	e8 bc fd ff ff       	call   1794 <putc>
    19d8:	eb 28                	jmp    1a02 <printf+0x195>
    19da:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    19e1:	00 
    19e2:	8b 45 08             	mov    0x8(%ebp),%eax
    19e5:	89 04 24             	mov    %eax,(%esp)
    19e8:	e8 a7 fd ff ff       	call   1794 <putc>
    19ed:	8b 45 e8             	mov    -0x18(%ebp),%eax
    19f0:	0f be c0             	movsbl %al,%eax
    19f3:	89 44 24 04          	mov    %eax,0x4(%esp)
    19f7:	8b 45 08             	mov    0x8(%ebp),%eax
    19fa:	89 04 24             	mov    %eax,(%esp)
    19fd:	e8 92 fd ff ff       	call   1794 <putc>
    1a02:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1a09:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1a0d:	8b 55 0c             	mov    0xc(%ebp),%edx
    1a10:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1a13:	8d 04 02             	lea    (%edx,%eax,1),%eax
    1a16:	0f b6 00             	movzbl (%eax),%eax
    1a19:	84 c0                	test   %al,%al
    1a1b:	0f 85 6e fe ff ff    	jne    188f <printf+0x22>
    1a21:	c9                   	leave  
    1a22:	c3                   	ret    
    1a23:	90                   	nop

00001a24 <free>:
    1a24:	55                   	push   %ebp
    1a25:	89 e5                	mov    %esp,%ebp
    1a27:	83 ec 10             	sub    $0x10,%esp
    1a2a:	8b 45 08             	mov    0x8(%ebp),%eax
    1a2d:	83 e8 08             	sub    $0x8,%eax
    1a30:	89 45 f8             	mov    %eax,-0x8(%ebp)
    1a33:	a1 f4 1f 00 00       	mov    0x1ff4,%eax
    1a38:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1a3b:	eb 24                	jmp    1a61 <free+0x3d>
    1a3d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1a40:	8b 00                	mov    (%eax),%eax
    1a42:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1a45:	77 12                	ja     1a59 <free+0x35>
    1a47:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1a4a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1a4d:	77 24                	ja     1a73 <free+0x4f>
    1a4f:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1a52:	8b 00                	mov    (%eax),%eax
    1a54:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1a57:	77 1a                	ja     1a73 <free+0x4f>
    1a59:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1a5c:	8b 00                	mov    (%eax),%eax
    1a5e:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1a61:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1a64:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1a67:	76 d4                	jbe    1a3d <free+0x19>
    1a69:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1a6c:	8b 00                	mov    (%eax),%eax
    1a6e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1a71:	76 ca                	jbe    1a3d <free+0x19>
    1a73:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1a76:	8b 40 04             	mov    0x4(%eax),%eax
    1a79:	c1 e0 03             	shl    $0x3,%eax
    1a7c:	89 c2                	mov    %eax,%edx
    1a7e:	03 55 f8             	add    -0x8(%ebp),%edx
    1a81:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1a84:	8b 00                	mov    (%eax),%eax
    1a86:	39 c2                	cmp    %eax,%edx
    1a88:	75 24                	jne    1aae <free+0x8a>
    1a8a:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1a8d:	8b 50 04             	mov    0x4(%eax),%edx
    1a90:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1a93:	8b 00                	mov    (%eax),%eax
    1a95:	8b 40 04             	mov    0x4(%eax),%eax
    1a98:	01 c2                	add    %eax,%edx
    1a9a:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1a9d:	89 50 04             	mov    %edx,0x4(%eax)
    1aa0:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1aa3:	8b 00                	mov    (%eax),%eax
    1aa5:	8b 10                	mov    (%eax),%edx
    1aa7:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1aaa:	89 10                	mov    %edx,(%eax)
    1aac:	eb 0a                	jmp    1ab8 <free+0x94>
    1aae:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1ab1:	8b 10                	mov    (%eax),%edx
    1ab3:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1ab6:	89 10                	mov    %edx,(%eax)
    1ab8:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1abb:	8b 40 04             	mov    0x4(%eax),%eax
    1abe:	c1 e0 03             	shl    $0x3,%eax
    1ac1:	03 45 fc             	add    -0x4(%ebp),%eax
    1ac4:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1ac7:	75 20                	jne    1ae9 <free+0xc5>
    1ac9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1acc:	8b 50 04             	mov    0x4(%eax),%edx
    1acf:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1ad2:	8b 40 04             	mov    0x4(%eax),%eax
    1ad5:	01 c2                	add    %eax,%edx
    1ad7:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1ada:	89 50 04             	mov    %edx,0x4(%eax)
    1add:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1ae0:	8b 10                	mov    (%eax),%edx
    1ae2:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1ae5:	89 10                	mov    %edx,(%eax)
    1ae7:	eb 08                	jmp    1af1 <free+0xcd>
    1ae9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1aec:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1aef:	89 10                	mov    %edx,(%eax)
    1af1:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1af4:	a3 f4 1f 00 00       	mov    %eax,0x1ff4
    1af9:	c9                   	leave  
    1afa:	c3                   	ret    

00001afb <morecore>:
    1afb:	55                   	push   %ebp
    1afc:	89 e5                	mov    %esp,%ebp
    1afe:	83 ec 28             	sub    $0x28,%esp
    1b01:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    1b08:	77 07                	ja     1b11 <morecore+0x16>
    1b0a:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
    1b11:	8b 45 08             	mov    0x8(%ebp),%eax
    1b14:	c1 e0 03             	shl    $0x3,%eax
    1b17:	89 04 24             	mov    %eax,(%esp)
    1b1a:	e8 35 fc ff ff       	call   1754 <sbrk>
    1b1f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1b22:	83 7d f0 ff          	cmpl   $0xffffffff,-0x10(%ebp)
    1b26:	75 07                	jne    1b2f <morecore+0x34>
    1b28:	b8 00 00 00 00       	mov    $0x0,%eax
    1b2d:	eb 22                	jmp    1b51 <morecore+0x56>
    1b2f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1b32:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1b35:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b38:	8b 55 08             	mov    0x8(%ebp),%edx
    1b3b:	89 50 04             	mov    %edx,0x4(%eax)
    1b3e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b41:	83 c0 08             	add    $0x8,%eax
    1b44:	89 04 24             	mov    %eax,(%esp)
    1b47:	e8 d8 fe ff ff       	call   1a24 <free>
    1b4c:	a1 f4 1f 00 00       	mov    0x1ff4,%eax
    1b51:	c9                   	leave  
    1b52:	c3                   	ret    

00001b53 <malloc>:
    1b53:	55                   	push   %ebp
    1b54:	89 e5                	mov    %esp,%ebp
    1b56:	83 ec 28             	sub    $0x28,%esp
    1b59:	8b 45 08             	mov    0x8(%ebp),%eax
    1b5c:	83 c0 07             	add    $0x7,%eax
    1b5f:	c1 e8 03             	shr    $0x3,%eax
    1b62:	83 c0 01             	add    $0x1,%eax
    1b65:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1b68:	a1 f4 1f 00 00       	mov    0x1ff4,%eax
    1b6d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1b70:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1b74:	75 23                	jne    1b99 <malloc+0x46>
    1b76:	c7 45 f0 ec 1f 00 00 	movl   $0x1fec,-0x10(%ebp)
    1b7d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1b80:	a3 f4 1f 00 00       	mov    %eax,0x1ff4
    1b85:	a1 f4 1f 00 00       	mov    0x1ff4,%eax
    1b8a:	a3 ec 1f 00 00       	mov    %eax,0x1fec
    1b8f:	c7 05 f0 1f 00 00 00 	movl   $0x0,0x1ff0
    1b96:	00 00 00 
    1b99:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1b9c:	8b 00                	mov    (%eax),%eax
    1b9e:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1ba1:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1ba4:	8b 40 04             	mov    0x4(%eax),%eax
    1ba7:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1baa:	72 4d                	jb     1bf9 <malloc+0xa6>
    1bac:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1baf:	8b 40 04             	mov    0x4(%eax),%eax
    1bb2:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1bb5:	75 0c                	jne    1bc3 <malloc+0x70>
    1bb7:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1bba:	8b 10                	mov    (%eax),%edx
    1bbc:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1bbf:	89 10                	mov    %edx,(%eax)
    1bc1:	eb 26                	jmp    1be9 <malloc+0x96>
    1bc3:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1bc6:	8b 40 04             	mov    0x4(%eax),%eax
    1bc9:	89 c2                	mov    %eax,%edx
    1bcb:	2b 55 f4             	sub    -0xc(%ebp),%edx
    1bce:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1bd1:	89 50 04             	mov    %edx,0x4(%eax)
    1bd4:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1bd7:	8b 40 04             	mov    0x4(%eax),%eax
    1bda:	c1 e0 03             	shl    $0x3,%eax
    1bdd:	01 45 ec             	add    %eax,-0x14(%ebp)
    1be0:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1be3:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1be6:	89 50 04             	mov    %edx,0x4(%eax)
    1be9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1bec:	a3 f4 1f 00 00       	mov    %eax,0x1ff4
    1bf1:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1bf4:	83 c0 08             	add    $0x8,%eax
    1bf7:	eb 38                	jmp    1c31 <malloc+0xde>
    1bf9:	a1 f4 1f 00 00       	mov    0x1ff4,%eax
    1bfe:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    1c01:	75 1b                	jne    1c1e <malloc+0xcb>
    1c03:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c06:	89 04 24             	mov    %eax,(%esp)
    1c09:	e8 ed fe ff ff       	call   1afb <morecore>
    1c0e:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1c11:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1c15:	75 07                	jne    1c1e <malloc+0xcb>
    1c17:	b8 00 00 00 00       	mov    $0x0,%eax
    1c1c:	eb 13                	jmp    1c31 <malloc+0xde>
    1c1e:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1c21:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1c24:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1c27:	8b 00                	mov    (%eax),%eax
    1c29:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1c2c:	e9 70 ff ff ff       	jmp    1ba1 <malloc+0x4e>
    1c31:	c9                   	leave  
    1c32:	c3                   	ret    
    1c33:	90                   	nop

00001c34 <xchg>:
    1c34:	55                   	push   %ebp
    1c35:	89 e5                	mov    %esp,%ebp
    1c37:	83 ec 10             	sub    $0x10,%esp
    1c3a:	8b 55 08             	mov    0x8(%ebp),%edx
    1c3d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1c40:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1c43:	f0 87 02             	lock xchg %eax,(%edx)
    1c46:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1c49:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1c4c:	c9                   	leave  
    1c4d:	c3                   	ret    

00001c4e <lock_init>:
    1c4e:	55                   	push   %ebp
    1c4f:	89 e5                	mov    %esp,%ebp
    1c51:	8b 45 08             	mov    0x8(%ebp),%eax
    1c54:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    1c5a:	5d                   	pop    %ebp
    1c5b:	c3                   	ret    

00001c5c <lock_acquire>:
    1c5c:	55                   	push   %ebp
    1c5d:	89 e5                	mov    %esp,%ebp
    1c5f:	83 ec 08             	sub    $0x8,%esp
    1c62:	8b 45 08             	mov    0x8(%ebp),%eax
    1c65:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    1c6c:	00 
    1c6d:	89 04 24             	mov    %eax,(%esp)
    1c70:	e8 bf ff ff ff       	call   1c34 <xchg>
    1c75:	85 c0                	test   %eax,%eax
    1c77:	75 e9                	jne    1c62 <lock_acquire+0x6>
    1c79:	c9                   	leave  
    1c7a:	c3                   	ret    

00001c7b <lock_release>:
    1c7b:	55                   	push   %ebp
    1c7c:	89 e5                	mov    %esp,%ebp
    1c7e:	83 ec 08             	sub    $0x8,%esp
    1c81:	8b 45 08             	mov    0x8(%ebp),%eax
    1c84:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1c8b:	00 
    1c8c:	89 04 24             	mov    %eax,(%esp)
    1c8f:	e8 a0 ff ff ff       	call   1c34 <xchg>
    1c94:	c9                   	leave  
    1c95:	c3                   	ret    

00001c96 <thread_create>:
    1c96:	55                   	push   %ebp
    1c97:	89 e5                	mov    %esp,%ebp
    1c99:	83 ec 28             	sub    $0x28,%esp
    1c9c:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    1ca3:	e8 ab fe ff ff       	call   1b53 <malloc>
    1ca8:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1cab:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1cae:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1cb1:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1cb4:	25 ff 0f 00 00       	and    $0xfff,%eax
    1cb9:	85 c0                	test   %eax,%eax
    1cbb:	74 15                	je     1cd2 <thread_create+0x3c>
    1cbd:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1cc0:	89 c2                	mov    %eax,%edx
    1cc2:	81 e2 ff 0f 00 00    	and    $0xfff,%edx
    1cc8:	b8 00 10 00 00       	mov    $0x1000,%eax
    1ccd:	29 d0                	sub    %edx,%eax
    1ccf:	01 45 f0             	add    %eax,-0x10(%ebp)
    1cd2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1cd6:	75 1b                	jne    1cf3 <thread_create+0x5d>
    1cd8:	c7 44 24 04 8e 1f 00 	movl   $0x1f8e,0x4(%esp)
    1cdf:	00 
    1ce0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1ce7:	e8 81 fb ff ff       	call   186d <printf>
    1cec:	b8 00 00 00 00       	mov    $0x0,%eax
    1cf1:	eb 6f                	jmp    1d62 <thread_create+0xcc>
    1cf3:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1cf6:	8b 55 08             	mov    0x8(%ebp),%edx
    1cf9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1cfc:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    1d00:	89 54 24 08          	mov    %edx,0x8(%esp)
    1d04:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    1d0b:	00 
    1d0c:	89 04 24             	mov    %eax,(%esp)
    1d0f:	e8 58 fa ff ff       	call   176c <clone>
    1d14:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1d17:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1d1b:	79 1b                	jns    1d38 <thread_create+0xa2>
    1d1d:	c7 44 24 04 9c 1f 00 	movl   $0x1f9c,0x4(%esp)
    1d24:	00 
    1d25:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1d2c:	e8 3c fb ff ff       	call   186d <printf>
    1d31:	b8 00 00 00 00       	mov    $0x0,%eax
    1d36:	eb 2a                	jmp    1d62 <thread_create+0xcc>
    1d38:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1d3c:	7e 05                	jle    1d43 <thread_create+0xad>
    1d3e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1d41:	eb 1f                	jmp    1d62 <thread_create+0xcc>
    1d43:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1d47:	75 14                	jne    1d5d <thread_create+0xc7>
    1d49:	c7 44 24 04 a9 1f 00 	movl   $0x1fa9,0x4(%esp)
    1d50:	00 
    1d51:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1d58:	e8 10 fb ff ff       	call   186d <printf>
    1d5d:	b8 00 00 00 00       	mov    $0x0,%eax
    1d62:	c9                   	leave  
    1d63:	c3                   	ret    

00001d64 <random>:
    1d64:	55                   	push   %ebp
    1d65:	89 e5                	mov    %esp,%ebp
    1d67:	a1 d0 1f 00 00       	mov    0x1fd0,%eax
    1d6c:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    1d72:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
    1d77:	a3 d0 1f 00 00       	mov    %eax,0x1fd0
    1d7c:	a1 d0 1f 00 00       	mov    0x1fd0,%eax
    1d81:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1d84:	ba 00 00 00 00       	mov    $0x0,%edx
    1d89:	f7 f1                	div    %ecx
    1d8b:	89 d0                	mov    %edx,%eax
    1d8d:	5d                   	pop    %ebp
    1d8e:	c3                   	ret    
    1d8f:	90                   	nop

00001d90 <init_q>:
    1d90:	55                   	push   %ebp
    1d91:	89 e5                	mov    %esp,%ebp
    1d93:	8b 45 08             	mov    0x8(%ebp),%eax
    1d96:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    1d9c:	8b 45 08             	mov    0x8(%ebp),%eax
    1d9f:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    1da6:	8b 45 08             	mov    0x8(%ebp),%eax
    1da9:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
    1db0:	5d                   	pop    %ebp
    1db1:	c3                   	ret    

00001db2 <add_q>:
    1db2:	55                   	push   %ebp
    1db3:	89 e5                	mov    %esp,%ebp
    1db5:	83 ec 28             	sub    $0x28,%esp
    1db8:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    1dbf:	e8 8f fd ff ff       	call   1b53 <malloc>
    1dc4:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1dc7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1dca:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    1dd1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1dd4:	8b 55 0c             	mov    0xc(%ebp),%edx
    1dd7:	89 10                	mov    %edx,(%eax)
    1dd9:	8b 45 08             	mov    0x8(%ebp),%eax
    1ddc:	8b 40 04             	mov    0x4(%eax),%eax
    1ddf:	85 c0                	test   %eax,%eax
    1de1:	75 0b                	jne    1dee <add_q+0x3c>
    1de3:	8b 45 08             	mov    0x8(%ebp),%eax
    1de6:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1de9:	89 50 04             	mov    %edx,0x4(%eax)
    1dec:	eb 0c                	jmp    1dfa <add_q+0x48>
    1dee:	8b 45 08             	mov    0x8(%ebp),%eax
    1df1:	8b 40 08             	mov    0x8(%eax),%eax
    1df4:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1df7:	89 50 04             	mov    %edx,0x4(%eax)
    1dfa:	8b 45 08             	mov    0x8(%ebp),%eax
    1dfd:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1e00:	89 50 08             	mov    %edx,0x8(%eax)
    1e03:	8b 45 08             	mov    0x8(%ebp),%eax
    1e06:	8b 00                	mov    (%eax),%eax
    1e08:	8d 50 01             	lea    0x1(%eax),%edx
    1e0b:	8b 45 08             	mov    0x8(%ebp),%eax
    1e0e:	89 10                	mov    %edx,(%eax)
    1e10:	c9                   	leave  
    1e11:	c3                   	ret    

00001e12 <empty_q>:
    1e12:	55                   	push   %ebp
    1e13:	89 e5                	mov    %esp,%ebp
    1e15:	8b 45 08             	mov    0x8(%ebp),%eax
    1e18:	8b 00                	mov    (%eax),%eax
    1e1a:	85 c0                	test   %eax,%eax
    1e1c:	75 07                	jne    1e25 <empty_q+0x13>
    1e1e:	b8 01 00 00 00       	mov    $0x1,%eax
    1e23:	eb 05                	jmp    1e2a <empty_q+0x18>
    1e25:	b8 00 00 00 00       	mov    $0x0,%eax
    1e2a:	5d                   	pop    %ebp
    1e2b:	c3                   	ret    

00001e2c <pop_q>:
    1e2c:	55                   	push   %ebp
    1e2d:	89 e5                	mov    %esp,%ebp
    1e2f:	83 ec 28             	sub    $0x28,%esp
    1e32:	8b 45 08             	mov    0x8(%ebp),%eax
    1e35:	89 04 24             	mov    %eax,(%esp)
    1e38:	e8 d5 ff ff ff       	call   1e12 <empty_q>
    1e3d:	85 c0                	test   %eax,%eax
    1e3f:	75 5d                	jne    1e9e <pop_q+0x72>
    1e41:	8b 45 08             	mov    0x8(%ebp),%eax
    1e44:	8b 40 04             	mov    0x4(%eax),%eax
    1e47:	8b 00                	mov    (%eax),%eax
    1e49:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1e4c:	8b 45 08             	mov    0x8(%ebp),%eax
    1e4f:	8b 40 04             	mov    0x4(%eax),%eax
    1e52:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1e55:	8b 45 08             	mov    0x8(%ebp),%eax
    1e58:	8b 40 04             	mov    0x4(%eax),%eax
    1e5b:	8b 50 04             	mov    0x4(%eax),%edx
    1e5e:	8b 45 08             	mov    0x8(%ebp),%eax
    1e61:	89 50 04             	mov    %edx,0x4(%eax)
    1e64:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e67:	89 04 24             	mov    %eax,(%esp)
    1e6a:	e8 b5 fb ff ff       	call   1a24 <free>
    1e6f:	8b 45 08             	mov    0x8(%ebp),%eax
    1e72:	8b 00                	mov    (%eax),%eax
    1e74:	8d 50 ff             	lea    -0x1(%eax),%edx
    1e77:	8b 45 08             	mov    0x8(%ebp),%eax
    1e7a:	89 10                	mov    %edx,(%eax)
    1e7c:	8b 45 08             	mov    0x8(%ebp),%eax
    1e7f:	8b 00                	mov    (%eax),%eax
    1e81:	85 c0                	test   %eax,%eax
    1e83:	75 14                	jne    1e99 <pop_q+0x6d>
    1e85:	8b 45 08             	mov    0x8(%ebp),%eax
    1e88:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    1e8f:	8b 45 08             	mov    0x8(%ebp),%eax
    1e92:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
    1e99:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1e9c:	eb 05                	jmp    1ea3 <pop_q+0x77>
    1e9e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1ea3:	c9                   	leave  
    1ea4:	c3                   	ret    
