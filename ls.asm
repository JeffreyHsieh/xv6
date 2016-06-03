
_ls:     file format elf32-i386


Disassembly of section .text:

00001000 <fmtname>:
    1000:	55                   	push   %ebp
    1001:	89 e5                	mov    %esp,%ebp
    1003:	53                   	push   %ebx
    1004:	83 ec 24             	sub    $0x24,%esp
    1007:	8b 45 08             	mov    0x8(%ebp),%eax
    100a:	89 04 24             	mov    %eax,(%esp)
    100d:	e8 db 03 00 00       	call   13ed <strlen>
    1012:	03 45 08             	add    0x8(%ebp),%eax
    1015:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1018:	eb 04                	jmp    101e <fmtname+0x1e>
    101a:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    101e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1021:	3b 45 08             	cmp    0x8(%ebp),%eax
    1024:	72 0a                	jb     1030 <fmtname+0x30>
    1026:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1029:	0f b6 00             	movzbl (%eax),%eax
    102c:	3c 2f                	cmp    $0x2f,%al
    102e:	75 ea                	jne    101a <fmtname+0x1a>
    1030:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1034:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1037:	89 04 24             	mov    %eax,(%esp)
    103a:	e8 ae 03 00 00       	call   13ed <strlen>
    103f:	83 f8 0d             	cmp    $0xd,%eax
    1042:	76 05                	jbe    1049 <fmtname+0x49>
    1044:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1047:	eb 5f                	jmp    10a8 <fmtname+0xa8>
    1049:	8b 45 f4             	mov    -0xc(%ebp),%eax
    104c:	89 04 24             	mov    %eax,(%esp)
    104f:	e8 99 03 00 00       	call   13ed <strlen>
    1054:	89 44 24 08          	mov    %eax,0x8(%esp)
    1058:	8b 45 f4             	mov    -0xc(%ebp),%eax
    105b:	89 44 24 04          	mov    %eax,0x4(%esp)
    105f:	c7 04 24 28 1e 00 00 	movl   $0x1e28,(%esp)
    1066:	e8 07 05 00 00       	call   1572 <memmove>
    106b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    106e:	89 04 24             	mov    %eax,(%esp)
    1071:	e8 77 03 00 00       	call   13ed <strlen>
    1076:	ba 0e 00 00 00       	mov    $0xe,%edx
    107b:	89 d3                	mov    %edx,%ebx
    107d:	29 c3                	sub    %eax,%ebx
    107f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1082:	89 04 24             	mov    %eax,(%esp)
    1085:	e8 63 03 00 00       	call   13ed <strlen>
    108a:	05 28 1e 00 00       	add    $0x1e28,%eax
    108f:	89 5c 24 08          	mov    %ebx,0x8(%esp)
    1093:	c7 44 24 04 20 00 00 	movl   $0x20,0x4(%esp)
    109a:	00 
    109b:	89 04 24             	mov    %eax,(%esp)
    109e:	e8 6f 03 00 00       	call   1412 <memset>
    10a3:	b8 28 1e 00 00       	mov    $0x1e28,%eax
    10a8:	83 c4 24             	add    $0x24,%esp
    10ab:	5b                   	pop    %ebx
    10ac:	5d                   	pop    %ebp
    10ad:	c3                   	ret    

000010ae <ls>:
    10ae:	55                   	push   %ebp
    10af:	89 e5                	mov    %esp,%ebp
    10b1:	57                   	push   %edi
    10b2:	56                   	push   %esi
    10b3:	53                   	push   %ebx
    10b4:	81 ec 5c 02 00 00    	sub    $0x25c,%esp
    10ba:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    10c1:	00 
    10c2:	8b 45 08             	mov    0x8(%ebp),%eax
    10c5:	89 04 24             	mov    %eax,(%esp)
    10c8:	e8 2b 05 00 00       	call   15f8 <open>
    10cd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    10d0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    10d4:	79 20                	jns    10f6 <ls+0x48>
    10d6:	8b 45 08             	mov    0x8(%ebp),%eax
    10d9:	89 44 24 08          	mov    %eax,0x8(%esp)
    10dd:	c7 44 24 04 91 1d 00 	movl   $0x1d91,0x4(%esp)
    10e4:	00 
    10e5:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
    10ec:	e8 68 06 00 00       	call   1759 <printf>
    10f1:	e9 01 02 00 00       	jmp    12f7 <ls+0x249>
    10f6:	8d 85 bc fd ff ff    	lea    -0x244(%ebp),%eax
    10fc:	89 44 24 04          	mov    %eax,0x4(%esp)
    1100:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1103:	89 04 24             	mov    %eax,(%esp)
    1106:	e8 05 05 00 00       	call   1610 <fstat>
    110b:	85 c0                	test   %eax,%eax
    110d:	79 2b                	jns    113a <ls+0x8c>
    110f:	8b 45 08             	mov    0x8(%ebp),%eax
    1112:	89 44 24 08          	mov    %eax,0x8(%esp)
    1116:	c7 44 24 04 a5 1d 00 	movl   $0x1da5,0x4(%esp)
    111d:	00 
    111e:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
    1125:	e8 2f 06 00 00       	call   1759 <printf>
    112a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    112d:	89 04 24             	mov    %eax,(%esp)
    1130:	e8 ab 04 00 00       	call   15e0 <close>
    1135:	e9 bd 01 00 00       	jmp    12f7 <ls+0x249>
    113a:	0f b7 85 bc fd ff ff 	movzwl -0x244(%ebp),%eax
    1141:	98                   	cwtl   
    1142:	83 f8 01             	cmp    $0x1,%eax
    1145:	74 53                	je     119a <ls+0xec>
    1147:	83 f8 02             	cmp    $0x2,%eax
    114a:	0f 85 9c 01 00 00    	jne    12ec <ls+0x23e>
    1150:	8b bd cc fd ff ff    	mov    -0x234(%ebp),%edi
    1156:	8b b5 c4 fd ff ff    	mov    -0x23c(%ebp),%esi
    115c:	0f b7 85 bc fd ff ff 	movzwl -0x244(%ebp),%eax
    1163:	0f bf d8             	movswl %ax,%ebx
    1166:	8b 45 08             	mov    0x8(%ebp),%eax
    1169:	89 04 24             	mov    %eax,(%esp)
    116c:	e8 8f fe ff ff       	call   1000 <fmtname>
    1171:	89 7c 24 14          	mov    %edi,0x14(%esp)
    1175:	89 74 24 10          	mov    %esi,0x10(%esp)
    1179:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
    117d:	89 44 24 08          	mov    %eax,0x8(%esp)
    1181:	c7 44 24 04 b9 1d 00 	movl   $0x1db9,0x4(%esp)
    1188:	00 
    1189:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1190:	e8 c4 05 00 00       	call   1759 <printf>
    1195:	e9 52 01 00 00       	jmp    12ec <ls+0x23e>
    119a:	8b 45 08             	mov    0x8(%ebp),%eax
    119d:	89 04 24             	mov    %eax,(%esp)
    11a0:	e8 48 02 00 00       	call   13ed <strlen>
    11a5:	83 c0 10             	add    $0x10,%eax
    11a8:	3d 00 02 00 00       	cmp    $0x200,%eax
    11ad:	76 19                	jbe    11c8 <ls+0x11a>
    11af:	c7 44 24 04 c6 1d 00 	movl   $0x1dc6,0x4(%esp)
    11b6:	00 
    11b7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    11be:	e8 96 05 00 00       	call   1759 <printf>
    11c3:	e9 24 01 00 00       	jmp    12ec <ls+0x23e>
    11c8:	8b 45 08             	mov    0x8(%ebp),%eax
    11cb:	89 44 24 04          	mov    %eax,0x4(%esp)
    11cf:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
    11d5:	89 04 24             	mov    %eax,(%esp)
    11d8:	e8 9c 01 00 00       	call   1379 <strcpy>
    11dd:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
    11e3:	89 04 24             	mov    %eax,(%esp)
    11e6:	e8 02 02 00 00       	call   13ed <strlen>
    11eb:	8d 95 e0 fd ff ff    	lea    -0x220(%ebp),%edx
    11f1:	8d 04 02             	lea    (%edx,%eax,1),%eax
    11f4:	89 45 e0             	mov    %eax,-0x20(%ebp)
    11f7:	8b 45 e0             	mov    -0x20(%ebp),%eax
    11fa:	c6 00 2f             	movb   $0x2f,(%eax)
    11fd:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1201:	e9 c0 00 00 00       	jmp    12c6 <ls+0x218>
    1206:	0f b7 85 d0 fd ff ff 	movzwl -0x230(%ebp),%eax
    120d:	66 85 c0             	test   %ax,%ax
    1210:	0f 84 af 00 00 00    	je     12c5 <ls+0x217>
    1216:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
    121d:	00 
    121e:	8d 85 d0 fd ff ff    	lea    -0x230(%ebp),%eax
    1224:	83 c0 02             	add    $0x2,%eax
    1227:	89 44 24 04          	mov    %eax,0x4(%esp)
    122b:	8b 45 e0             	mov    -0x20(%ebp),%eax
    122e:	89 04 24             	mov    %eax,(%esp)
    1231:	e8 3c 03 00 00       	call   1572 <memmove>
    1236:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1239:	83 c0 0e             	add    $0xe,%eax
    123c:	c6 00 00             	movb   $0x0,(%eax)
    123f:	8d 85 bc fd ff ff    	lea    -0x244(%ebp),%eax
    1245:	89 44 24 04          	mov    %eax,0x4(%esp)
    1249:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
    124f:	89 04 24             	mov    %eax,(%esp)
    1252:	e8 81 02 00 00       	call   14d8 <stat>
    1257:	85 c0                	test   %eax,%eax
    1259:	79 20                	jns    127b <ls+0x1cd>
    125b:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
    1261:	89 44 24 08          	mov    %eax,0x8(%esp)
    1265:	c7 44 24 04 a5 1d 00 	movl   $0x1da5,0x4(%esp)
    126c:	00 
    126d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1274:	e8 e0 04 00 00       	call   1759 <printf>
    1279:	eb 4b                	jmp    12c6 <ls+0x218>
    127b:	8b bd cc fd ff ff    	mov    -0x234(%ebp),%edi
    1281:	8b b5 c4 fd ff ff    	mov    -0x23c(%ebp),%esi
    1287:	0f b7 85 bc fd ff ff 	movzwl -0x244(%ebp),%eax
    128e:	0f bf d8             	movswl %ax,%ebx
    1291:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
    1297:	89 04 24             	mov    %eax,(%esp)
    129a:	e8 61 fd ff ff       	call   1000 <fmtname>
    129f:	89 7c 24 14          	mov    %edi,0x14(%esp)
    12a3:	89 74 24 10          	mov    %esi,0x10(%esp)
    12a7:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
    12ab:	89 44 24 08          	mov    %eax,0x8(%esp)
    12af:	c7 44 24 04 b9 1d 00 	movl   $0x1db9,0x4(%esp)
    12b6:	00 
    12b7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    12be:	e8 96 04 00 00       	call   1759 <printf>
    12c3:	eb 01                	jmp    12c6 <ls+0x218>
    12c5:	90                   	nop
    12c6:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    12cd:	00 
    12ce:	8d 85 d0 fd ff ff    	lea    -0x230(%ebp),%eax
    12d4:	89 44 24 04          	mov    %eax,0x4(%esp)
    12d8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    12db:	89 04 24             	mov    %eax,(%esp)
    12de:	e8 ed 02 00 00       	call   15d0 <read>
    12e3:	83 f8 10             	cmp    $0x10,%eax
    12e6:	0f 84 1a ff ff ff    	je     1206 <ls+0x158>
    12ec:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    12ef:	89 04 24             	mov    %eax,(%esp)
    12f2:	e8 e9 02 00 00       	call   15e0 <close>
    12f7:	81 c4 5c 02 00 00    	add    $0x25c,%esp
    12fd:	5b                   	pop    %ebx
    12fe:	5e                   	pop    %esi
    12ff:	5f                   	pop    %edi
    1300:	5d                   	pop    %ebp
    1301:	c3                   	ret    

00001302 <main>:
    1302:	55                   	push   %ebp
    1303:	89 e5                	mov    %esp,%ebp
    1305:	83 e4 f0             	and    $0xfffffff0,%esp
    1308:	83 ec 20             	sub    $0x20,%esp
    130b:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
    130f:	7f 11                	jg     1322 <main+0x20>
    1311:	c7 04 24 d9 1d 00 00 	movl   $0x1dd9,(%esp)
    1318:	e8 91 fd ff ff       	call   10ae <ls>
    131d:	e8 96 02 00 00       	call   15b8 <exit>
    1322:	c7 44 24 1c 01 00 00 	movl   $0x1,0x1c(%esp)
    1329:	00 
    132a:	eb 19                	jmp    1345 <main+0x43>
    132c:	8b 44 24 1c          	mov    0x1c(%esp),%eax
    1330:	c1 e0 02             	shl    $0x2,%eax
    1333:	03 45 0c             	add    0xc(%ebp),%eax
    1336:	8b 00                	mov    (%eax),%eax
    1338:	89 04 24             	mov    %eax,(%esp)
    133b:	e8 6e fd ff ff       	call   10ae <ls>
    1340:	83 44 24 1c 01       	addl   $0x1,0x1c(%esp)
    1345:	8b 44 24 1c          	mov    0x1c(%esp),%eax
    1349:	3b 45 08             	cmp    0x8(%ebp),%eax
    134c:	7c de                	jl     132c <main+0x2a>
    134e:	e8 65 02 00 00       	call   15b8 <exit>
    1353:	90                   	nop

00001354 <stosb>:
    1354:	55                   	push   %ebp
    1355:	89 e5                	mov    %esp,%ebp
    1357:	57                   	push   %edi
    1358:	53                   	push   %ebx
    1359:	8b 4d 08             	mov    0x8(%ebp),%ecx
    135c:	8b 55 10             	mov    0x10(%ebp),%edx
    135f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1362:	89 cb                	mov    %ecx,%ebx
    1364:	89 df                	mov    %ebx,%edi
    1366:	89 d1                	mov    %edx,%ecx
    1368:	fc                   	cld    
    1369:	f3 aa                	rep stos %al,%es:(%edi)
    136b:	89 ca                	mov    %ecx,%edx
    136d:	89 fb                	mov    %edi,%ebx
    136f:	89 5d 08             	mov    %ebx,0x8(%ebp)
    1372:	89 55 10             	mov    %edx,0x10(%ebp)
    1375:	5b                   	pop    %ebx
    1376:	5f                   	pop    %edi
    1377:	5d                   	pop    %ebp
    1378:	c3                   	ret    

00001379 <strcpy>:
    1379:	55                   	push   %ebp
    137a:	89 e5                	mov    %esp,%ebp
    137c:	83 ec 10             	sub    $0x10,%esp
    137f:	8b 45 08             	mov    0x8(%ebp),%eax
    1382:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1385:	8b 45 0c             	mov    0xc(%ebp),%eax
    1388:	0f b6 10             	movzbl (%eax),%edx
    138b:	8b 45 08             	mov    0x8(%ebp),%eax
    138e:	88 10                	mov    %dl,(%eax)
    1390:	8b 45 08             	mov    0x8(%ebp),%eax
    1393:	0f b6 00             	movzbl (%eax),%eax
    1396:	84 c0                	test   %al,%al
    1398:	0f 95 c0             	setne  %al
    139b:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    139f:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    13a3:	84 c0                	test   %al,%al
    13a5:	75 de                	jne    1385 <strcpy+0xc>
    13a7:	8b 45 fc             	mov    -0x4(%ebp),%eax
    13aa:	c9                   	leave  
    13ab:	c3                   	ret    

000013ac <strcmp>:
    13ac:	55                   	push   %ebp
    13ad:	89 e5                	mov    %esp,%ebp
    13af:	eb 08                	jmp    13b9 <strcmp+0xd>
    13b1:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    13b5:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    13b9:	8b 45 08             	mov    0x8(%ebp),%eax
    13bc:	0f b6 00             	movzbl (%eax),%eax
    13bf:	84 c0                	test   %al,%al
    13c1:	74 10                	je     13d3 <strcmp+0x27>
    13c3:	8b 45 08             	mov    0x8(%ebp),%eax
    13c6:	0f b6 10             	movzbl (%eax),%edx
    13c9:	8b 45 0c             	mov    0xc(%ebp),%eax
    13cc:	0f b6 00             	movzbl (%eax),%eax
    13cf:	38 c2                	cmp    %al,%dl
    13d1:	74 de                	je     13b1 <strcmp+0x5>
    13d3:	8b 45 08             	mov    0x8(%ebp),%eax
    13d6:	0f b6 00             	movzbl (%eax),%eax
    13d9:	0f b6 d0             	movzbl %al,%edx
    13dc:	8b 45 0c             	mov    0xc(%ebp),%eax
    13df:	0f b6 00             	movzbl (%eax),%eax
    13e2:	0f b6 c0             	movzbl %al,%eax
    13e5:	89 d1                	mov    %edx,%ecx
    13e7:	29 c1                	sub    %eax,%ecx
    13e9:	89 c8                	mov    %ecx,%eax
    13eb:	5d                   	pop    %ebp
    13ec:	c3                   	ret    

000013ed <strlen>:
    13ed:	55                   	push   %ebp
    13ee:	89 e5                	mov    %esp,%ebp
    13f0:	83 ec 10             	sub    $0x10,%esp
    13f3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    13fa:	eb 04                	jmp    1400 <strlen+0x13>
    13fc:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    1400:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1403:	03 45 08             	add    0x8(%ebp),%eax
    1406:	0f b6 00             	movzbl (%eax),%eax
    1409:	84 c0                	test   %al,%al
    140b:	75 ef                	jne    13fc <strlen+0xf>
    140d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1410:	c9                   	leave  
    1411:	c3                   	ret    

00001412 <memset>:
    1412:	55                   	push   %ebp
    1413:	89 e5                	mov    %esp,%ebp
    1415:	83 ec 0c             	sub    $0xc,%esp
    1418:	8b 45 10             	mov    0x10(%ebp),%eax
    141b:	89 44 24 08          	mov    %eax,0x8(%esp)
    141f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1422:	89 44 24 04          	mov    %eax,0x4(%esp)
    1426:	8b 45 08             	mov    0x8(%ebp),%eax
    1429:	89 04 24             	mov    %eax,(%esp)
    142c:	e8 23 ff ff ff       	call   1354 <stosb>
    1431:	8b 45 08             	mov    0x8(%ebp),%eax
    1434:	c9                   	leave  
    1435:	c3                   	ret    

00001436 <strchr>:
    1436:	55                   	push   %ebp
    1437:	89 e5                	mov    %esp,%ebp
    1439:	83 ec 04             	sub    $0x4,%esp
    143c:	8b 45 0c             	mov    0xc(%ebp),%eax
    143f:	88 45 fc             	mov    %al,-0x4(%ebp)
    1442:	eb 14                	jmp    1458 <strchr+0x22>
    1444:	8b 45 08             	mov    0x8(%ebp),%eax
    1447:	0f b6 00             	movzbl (%eax),%eax
    144a:	3a 45 fc             	cmp    -0x4(%ebp),%al
    144d:	75 05                	jne    1454 <strchr+0x1e>
    144f:	8b 45 08             	mov    0x8(%ebp),%eax
    1452:	eb 13                	jmp    1467 <strchr+0x31>
    1454:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1458:	8b 45 08             	mov    0x8(%ebp),%eax
    145b:	0f b6 00             	movzbl (%eax),%eax
    145e:	84 c0                	test   %al,%al
    1460:	75 e2                	jne    1444 <strchr+0xe>
    1462:	b8 00 00 00 00       	mov    $0x0,%eax
    1467:	c9                   	leave  
    1468:	c3                   	ret    

00001469 <gets>:
    1469:	55                   	push   %ebp
    146a:	89 e5                	mov    %esp,%ebp
    146c:	83 ec 28             	sub    $0x28,%esp
    146f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1476:	eb 44                	jmp    14bc <gets+0x53>
    1478:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    147f:	00 
    1480:	8d 45 ef             	lea    -0x11(%ebp),%eax
    1483:	89 44 24 04          	mov    %eax,0x4(%esp)
    1487:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    148e:	e8 3d 01 00 00       	call   15d0 <read>
    1493:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1496:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    149a:	7e 2d                	jle    14c9 <gets+0x60>
    149c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    149f:	03 45 08             	add    0x8(%ebp),%eax
    14a2:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
    14a6:	88 10                	mov    %dl,(%eax)
    14a8:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    14ac:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    14b0:	3c 0a                	cmp    $0xa,%al
    14b2:	74 16                	je     14ca <gets+0x61>
    14b4:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    14b8:	3c 0d                	cmp    $0xd,%al
    14ba:	74 0e                	je     14ca <gets+0x61>
    14bc:	8b 45 f0             	mov    -0x10(%ebp),%eax
    14bf:	83 c0 01             	add    $0x1,%eax
    14c2:	3b 45 0c             	cmp    0xc(%ebp),%eax
    14c5:	7c b1                	jl     1478 <gets+0xf>
    14c7:	eb 01                	jmp    14ca <gets+0x61>
    14c9:	90                   	nop
    14ca:	8b 45 f0             	mov    -0x10(%ebp),%eax
    14cd:	03 45 08             	add    0x8(%ebp),%eax
    14d0:	c6 00 00             	movb   $0x0,(%eax)
    14d3:	8b 45 08             	mov    0x8(%ebp),%eax
    14d6:	c9                   	leave  
    14d7:	c3                   	ret    

000014d8 <stat>:
    14d8:	55                   	push   %ebp
    14d9:	89 e5                	mov    %esp,%ebp
    14db:	83 ec 28             	sub    $0x28,%esp
    14de:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    14e5:	00 
    14e6:	8b 45 08             	mov    0x8(%ebp),%eax
    14e9:	89 04 24             	mov    %eax,(%esp)
    14ec:	e8 07 01 00 00       	call   15f8 <open>
    14f1:	89 45 f0             	mov    %eax,-0x10(%ebp)
    14f4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    14f8:	79 07                	jns    1501 <stat+0x29>
    14fa:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    14ff:	eb 23                	jmp    1524 <stat+0x4c>
    1501:	8b 45 0c             	mov    0xc(%ebp),%eax
    1504:	89 44 24 04          	mov    %eax,0x4(%esp)
    1508:	8b 45 f0             	mov    -0x10(%ebp),%eax
    150b:	89 04 24             	mov    %eax,(%esp)
    150e:	e8 fd 00 00 00       	call   1610 <fstat>
    1513:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1516:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1519:	89 04 24             	mov    %eax,(%esp)
    151c:	e8 bf 00 00 00       	call   15e0 <close>
    1521:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1524:	c9                   	leave  
    1525:	c3                   	ret    

00001526 <atoi>:
    1526:	55                   	push   %ebp
    1527:	89 e5                	mov    %esp,%ebp
    1529:	83 ec 10             	sub    $0x10,%esp
    152c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    1533:	eb 24                	jmp    1559 <atoi+0x33>
    1535:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1538:	89 d0                	mov    %edx,%eax
    153a:	c1 e0 02             	shl    $0x2,%eax
    153d:	01 d0                	add    %edx,%eax
    153f:	01 c0                	add    %eax,%eax
    1541:	89 c2                	mov    %eax,%edx
    1543:	8b 45 08             	mov    0x8(%ebp),%eax
    1546:	0f b6 00             	movzbl (%eax),%eax
    1549:	0f be c0             	movsbl %al,%eax
    154c:	8d 04 02             	lea    (%edx,%eax,1),%eax
    154f:	83 e8 30             	sub    $0x30,%eax
    1552:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1555:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1559:	8b 45 08             	mov    0x8(%ebp),%eax
    155c:	0f b6 00             	movzbl (%eax),%eax
    155f:	3c 2f                	cmp    $0x2f,%al
    1561:	7e 0a                	jle    156d <atoi+0x47>
    1563:	8b 45 08             	mov    0x8(%ebp),%eax
    1566:	0f b6 00             	movzbl (%eax),%eax
    1569:	3c 39                	cmp    $0x39,%al
    156b:	7e c8                	jle    1535 <atoi+0xf>
    156d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1570:	c9                   	leave  
    1571:	c3                   	ret    

00001572 <memmove>:
    1572:	55                   	push   %ebp
    1573:	89 e5                	mov    %esp,%ebp
    1575:	83 ec 10             	sub    $0x10,%esp
    1578:	8b 45 08             	mov    0x8(%ebp),%eax
    157b:	89 45 f8             	mov    %eax,-0x8(%ebp)
    157e:	8b 45 0c             	mov    0xc(%ebp),%eax
    1581:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1584:	eb 13                	jmp    1599 <memmove+0x27>
    1586:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1589:	0f b6 10             	movzbl (%eax),%edx
    158c:	8b 45 f8             	mov    -0x8(%ebp),%eax
    158f:	88 10                	mov    %dl,(%eax)
    1591:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    1595:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    1599:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    159d:	0f 9f c0             	setg   %al
    15a0:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    15a4:	84 c0                	test   %al,%al
    15a6:	75 de                	jne    1586 <memmove+0x14>
    15a8:	8b 45 08             	mov    0x8(%ebp),%eax
    15ab:	c9                   	leave  
    15ac:	c3                   	ret    
    15ad:	90                   	nop
    15ae:	90                   	nop
    15af:	90                   	nop

000015b0 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    15b0:	b8 01 00 00 00       	mov    $0x1,%eax
    15b5:	cd 40                	int    $0x40
    15b7:	c3                   	ret    

000015b8 <exit>:
SYSCALL(exit)
    15b8:	b8 02 00 00 00       	mov    $0x2,%eax
    15bd:	cd 40                	int    $0x40
    15bf:	c3                   	ret    

000015c0 <wait>:
SYSCALL(wait)
    15c0:	b8 03 00 00 00       	mov    $0x3,%eax
    15c5:	cd 40                	int    $0x40
    15c7:	c3                   	ret    

000015c8 <pipe>:
SYSCALL(pipe)
    15c8:	b8 04 00 00 00       	mov    $0x4,%eax
    15cd:	cd 40                	int    $0x40
    15cf:	c3                   	ret    

000015d0 <read>:
SYSCALL(read)
    15d0:	b8 05 00 00 00       	mov    $0x5,%eax
    15d5:	cd 40                	int    $0x40
    15d7:	c3                   	ret    

000015d8 <write>:
SYSCALL(write)
    15d8:	b8 10 00 00 00       	mov    $0x10,%eax
    15dd:	cd 40                	int    $0x40
    15df:	c3                   	ret    

000015e0 <close>:
SYSCALL(close)
    15e0:	b8 15 00 00 00       	mov    $0x15,%eax
    15e5:	cd 40                	int    $0x40
    15e7:	c3                   	ret    

000015e8 <kill>:
SYSCALL(kill)
    15e8:	b8 06 00 00 00       	mov    $0x6,%eax
    15ed:	cd 40                	int    $0x40
    15ef:	c3                   	ret    

000015f0 <exec>:
SYSCALL(exec)
    15f0:	b8 07 00 00 00       	mov    $0x7,%eax
    15f5:	cd 40                	int    $0x40
    15f7:	c3                   	ret    

000015f8 <open>:
SYSCALL(open)
    15f8:	b8 0f 00 00 00       	mov    $0xf,%eax
    15fd:	cd 40                	int    $0x40
    15ff:	c3                   	ret    

00001600 <mknod>:
SYSCALL(mknod)
    1600:	b8 11 00 00 00       	mov    $0x11,%eax
    1605:	cd 40                	int    $0x40
    1607:	c3                   	ret    

00001608 <unlink>:
SYSCALL(unlink)
    1608:	b8 12 00 00 00       	mov    $0x12,%eax
    160d:	cd 40                	int    $0x40
    160f:	c3                   	ret    

00001610 <fstat>:
SYSCALL(fstat)
    1610:	b8 08 00 00 00       	mov    $0x8,%eax
    1615:	cd 40                	int    $0x40
    1617:	c3                   	ret    

00001618 <link>:
SYSCALL(link)
    1618:	b8 13 00 00 00       	mov    $0x13,%eax
    161d:	cd 40                	int    $0x40
    161f:	c3                   	ret    

00001620 <mkdir>:
SYSCALL(mkdir)
    1620:	b8 14 00 00 00       	mov    $0x14,%eax
    1625:	cd 40                	int    $0x40
    1627:	c3                   	ret    

00001628 <chdir>:
SYSCALL(chdir)
    1628:	b8 09 00 00 00       	mov    $0x9,%eax
    162d:	cd 40                	int    $0x40
    162f:	c3                   	ret    

00001630 <dup>:
SYSCALL(dup)
    1630:	b8 0a 00 00 00       	mov    $0xa,%eax
    1635:	cd 40                	int    $0x40
    1637:	c3                   	ret    

00001638 <getpid>:
SYSCALL(getpid)
    1638:	b8 0b 00 00 00       	mov    $0xb,%eax
    163d:	cd 40                	int    $0x40
    163f:	c3                   	ret    

00001640 <sbrk>:
SYSCALL(sbrk)
    1640:	b8 0c 00 00 00       	mov    $0xc,%eax
    1645:	cd 40                	int    $0x40
    1647:	c3                   	ret    

00001648 <sleep>:
SYSCALL(sleep)
    1648:	b8 0d 00 00 00       	mov    $0xd,%eax
    164d:	cd 40                	int    $0x40
    164f:	c3                   	ret    

00001650 <uptime>:
SYSCALL(uptime)
    1650:	b8 0e 00 00 00       	mov    $0xe,%eax
    1655:	cd 40                	int    $0x40
    1657:	c3                   	ret    

00001658 <clone>:
SYSCALL(clone)
    1658:	b8 16 00 00 00       	mov    $0x16,%eax
    165d:	cd 40                	int    $0x40
    165f:	c3                   	ret    

00001660 <texit>:
SYSCALL(texit)
    1660:	b8 17 00 00 00       	mov    $0x17,%eax
    1665:	cd 40                	int    $0x40
    1667:	c3                   	ret    

00001668 <tsleep>:
SYSCALL(tsleep)
    1668:	b8 18 00 00 00       	mov    $0x18,%eax
    166d:	cd 40                	int    $0x40
    166f:	c3                   	ret    

00001670 <twakeup>:
SYSCALL(twakeup)
    1670:	b8 19 00 00 00       	mov    $0x19,%eax
    1675:	cd 40                	int    $0x40
    1677:	c3                   	ret    

00001678 <thread_yield>:
SYSCALL(thread_yield)
    1678:	b8 1a 00 00 00       	mov    $0x1a,%eax
    167d:	cd 40                	int    $0x40
    167f:	c3                   	ret    

00001680 <putc>:
    1680:	55                   	push   %ebp
    1681:	89 e5                	mov    %esp,%ebp
    1683:	83 ec 28             	sub    $0x28,%esp
    1686:	8b 45 0c             	mov    0xc(%ebp),%eax
    1689:	88 45 f4             	mov    %al,-0xc(%ebp)
    168c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1693:	00 
    1694:	8d 45 f4             	lea    -0xc(%ebp),%eax
    1697:	89 44 24 04          	mov    %eax,0x4(%esp)
    169b:	8b 45 08             	mov    0x8(%ebp),%eax
    169e:	89 04 24             	mov    %eax,(%esp)
    16a1:	e8 32 ff ff ff       	call   15d8 <write>
    16a6:	c9                   	leave  
    16a7:	c3                   	ret    

000016a8 <printint>:
    16a8:	55                   	push   %ebp
    16a9:	89 e5                	mov    %esp,%ebp
    16ab:	53                   	push   %ebx
    16ac:	83 ec 44             	sub    $0x44,%esp
    16af:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    16b6:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    16ba:	74 17                	je     16d3 <printint+0x2b>
    16bc:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    16c0:	79 11                	jns    16d3 <printint+0x2b>
    16c2:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    16c9:	8b 45 0c             	mov    0xc(%ebp),%eax
    16cc:	f7 d8                	neg    %eax
    16ce:	89 45 f4             	mov    %eax,-0xc(%ebp)
    16d1:	eb 06                	jmp    16d9 <printint+0x31>
    16d3:	8b 45 0c             	mov    0xc(%ebp),%eax
    16d6:	89 45 f4             	mov    %eax,-0xc(%ebp)
    16d9:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    16e0:	8b 4d ec             	mov    -0x14(%ebp),%ecx
    16e3:	8b 5d 10             	mov    0x10(%ebp),%ebx
    16e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16e9:	ba 00 00 00 00       	mov    $0x0,%edx
    16ee:	f7 f3                	div    %ebx
    16f0:	89 d0                	mov    %edx,%eax
    16f2:	0f b6 80 10 1e 00 00 	movzbl 0x1e10(%eax),%eax
    16f9:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
    16fd:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1701:	8b 45 10             	mov    0x10(%ebp),%eax
    1704:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    1707:	8b 45 f4             	mov    -0xc(%ebp),%eax
    170a:	ba 00 00 00 00       	mov    $0x0,%edx
    170f:	f7 75 d4             	divl   -0x2c(%ebp)
    1712:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1715:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1719:	75 c5                	jne    16e0 <printint+0x38>
    171b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    171f:	74 28                	je     1749 <printint+0xa1>
    1721:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1724:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)
    1729:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    172d:	eb 1a                	jmp    1749 <printint+0xa1>
    172f:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1732:	0f b6 44 05 dc       	movzbl -0x24(%ebp,%eax,1),%eax
    1737:	0f be c0             	movsbl %al,%eax
    173a:	89 44 24 04          	mov    %eax,0x4(%esp)
    173e:	8b 45 08             	mov    0x8(%ebp),%eax
    1741:	89 04 24             	mov    %eax,(%esp)
    1744:	e8 37 ff ff ff       	call   1680 <putc>
    1749:	83 6d ec 01          	subl   $0x1,-0x14(%ebp)
    174d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1751:	79 dc                	jns    172f <printint+0x87>
    1753:	83 c4 44             	add    $0x44,%esp
    1756:	5b                   	pop    %ebx
    1757:	5d                   	pop    %ebp
    1758:	c3                   	ret    

00001759 <printf>:
    1759:	55                   	push   %ebp
    175a:	89 e5                	mov    %esp,%ebp
    175c:	83 ec 38             	sub    $0x38,%esp
    175f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1766:	8d 45 0c             	lea    0xc(%ebp),%eax
    1769:	83 c0 04             	add    $0x4,%eax
    176c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    176f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1776:	e9 7e 01 00 00       	jmp    18f9 <printf+0x1a0>
    177b:	8b 55 0c             	mov    0xc(%ebp),%edx
    177e:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1781:	8d 04 02             	lea    (%edx,%eax,1),%eax
    1784:	0f b6 00             	movzbl (%eax),%eax
    1787:	0f be c0             	movsbl %al,%eax
    178a:	25 ff 00 00 00       	and    $0xff,%eax
    178f:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1792:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1796:	75 2c                	jne    17c4 <printf+0x6b>
    1798:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    179c:	75 0c                	jne    17aa <printf+0x51>
    179e:	c7 45 f0 25 00 00 00 	movl   $0x25,-0x10(%ebp)
    17a5:	e9 4b 01 00 00       	jmp    18f5 <printf+0x19c>
    17aa:	8b 45 e8             	mov    -0x18(%ebp),%eax
    17ad:	0f be c0             	movsbl %al,%eax
    17b0:	89 44 24 04          	mov    %eax,0x4(%esp)
    17b4:	8b 45 08             	mov    0x8(%ebp),%eax
    17b7:	89 04 24             	mov    %eax,(%esp)
    17ba:	e8 c1 fe ff ff       	call   1680 <putc>
    17bf:	e9 31 01 00 00       	jmp    18f5 <printf+0x19c>
    17c4:	83 7d f0 25          	cmpl   $0x25,-0x10(%ebp)
    17c8:	0f 85 27 01 00 00    	jne    18f5 <printf+0x19c>
    17ce:	83 7d e8 64          	cmpl   $0x64,-0x18(%ebp)
    17d2:	75 2d                	jne    1801 <printf+0xa8>
    17d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17d7:	8b 00                	mov    (%eax),%eax
    17d9:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    17e0:	00 
    17e1:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    17e8:	00 
    17e9:	89 44 24 04          	mov    %eax,0x4(%esp)
    17ed:	8b 45 08             	mov    0x8(%ebp),%eax
    17f0:	89 04 24             	mov    %eax,(%esp)
    17f3:	e8 b0 fe ff ff       	call   16a8 <printint>
    17f8:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    17fc:	e9 ed 00 00 00       	jmp    18ee <printf+0x195>
    1801:	83 7d e8 78          	cmpl   $0x78,-0x18(%ebp)
    1805:	74 06                	je     180d <printf+0xb4>
    1807:	83 7d e8 70          	cmpl   $0x70,-0x18(%ebp)
    180b:	75 2d                	jne    183a <printf+0xe1>
    180d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1810:	8b 00                	mov    (%eax),%eax
    1812:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    1819:	00 
    181a:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    1821:	00 
    1822:	89 44 24 04          	mov    %eax,0x4(%esp)
    1826:	8b 45 08             	mov    0x8(%ebp),%eax
    1829:	89 04 24             	mov    %eax,(%esp)
    182c:	e8 77 fe ff ff       	call   16a8 <printint>
    1831:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    1835:	e9 b4 00 00 00       	jmp    18ee <printf+0x195>
    183a:	83 7d e8 73          	cmpl   $0x73,-0x18(%ebp)
    183e:	75 46                	jne    1886 <printf+0x12d>
    1840:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1843:	8b 00                	mov    (%eax),%eax
    1845:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    1848:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    184c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    1850:	75 27                	jne    1879 <printf+0x120>
    1852:	c7 45 e4 db 1d 00 00 	movl   $0x1ddb,-0x1c(%ebp)
    1859:	eb 1f                	jmp    187a <printf+0x121>
    185b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    185e:	0f b6 00             	movzbl (%eax),%eax
    1861:	0f be c0             	movsbl %al,%eax
    1864:	89 44 24 04          	mov    %eax,0x4(%esp)
    1868:	8b 45 08             	mov    0x8(%ebp),%eax
    186b:	89 04 24             	mov    %eax,(%esp)
    186e:	e8 0d fe ff ff       	call   1680 <putc>
    1873:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1877:	eb 01                	jmp    187a <printf+0x121>
    1879:	90                   	nop
    187a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    187d:	0f b6 00             	movzbl (%eax),%eax
    1880:	84 c0                	test   %al,%al
    1882:	75 d7                	jne    185b <printf+0x102>
    1884:	eb 68                	jmp    18ee <printf+0x195>
    1886:	83 7d e8 63          	cmpl   $0x63,-0x18(%ebp)
    188a:	75 1d                	jne    18a9 <printf+0x150>
    188c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    188f:	8b 00                	mov    (%eax),%eax
    1891:	0f be c0             	movsbl %al,%eax
    1894:	89 44 24 04          	mov    %eax,0x4(%esp)
    1898:	8b 45 08             	mov    0x8(%ebp),%eax
    189b:	89 04 24             	mov    %eax,(%esp)
    189e:	e8 dd fd ff ff       	call   1680 <putc>
    18a3:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    18a7:	eb 45                	jmp    18ee <printf+0x195>
    18a9:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    18ad:	75 17                	jne    18c6 <printf+0x16d>
    18af:	8b 45 e8             	mov    -0x18(%ebp),%eax
    18b2:	0f be c0             	movsbl %al,%eax
    18b5:	89 44 24 04          	mov    %eax,0x4(%esp)
    18b9:	8b 45 08             	mov    0x8(%ebp),%eax
    18bc:	89 04 24             	mov    %eax,(%esp)
    18bf:	e8 bc fd ff ff       	call   1680 <putc>
    18c4:	eb 28                	jmp    18ee <printf+0x195>
    18c6:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    18cd:	00 
    18ce:	8b 45 08             	mov    0x8(%ebp),%eax
    18d1:	89 04 24             	mov    %eax,(%esp)
    18d4:	e8 a7 fd ff ff       	call   1680 <putc>
    18d9:	8b 45 e8             	mov    -0x18(%ebp),%eax
    18dc:	0f be c0             	movsbl %al,%eax
    18df:	89 44 24 04          	mov    %eax,0x4(%esp)
    18e3:	8b 45 08             	mov    0x8(%ebp),%eax
    18e6:	89 04 24             	mov    %eax,(%esp)
    18e9:	e8 92 fd ff ff       	call   1680 <putc>
    18ee:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    18f5:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    18f9:	8b 55 0c             	mov    0xc(%ebp),%edx
    18fc:	8b 45 ec             	mov    -0x14(%ebp),%eax
    18ff:	8d 04 02             	lea    (%edx,%eax,1),%eax
    1902:	0f b6 00             	movzbl (%eax),%eax
    1905:	84 c0                	test   %al,%al
    1907:	0f 85 6e fe ff ff    	jne    177b <printf+0x22>
    190d:	c9                   	leave  
    190e:	c3                   	ret    
    190f:	90                   	nop

00001910 <free>:
    1910:	55                   	push   %ebp
    1911:	89 e5                	mov    %esp,%ebp
    1913:	83 ec 10             	sub    $0x10,%esp
    1916:	8b 45 08             	mov    0x8(%ebp),%eax
    1919:	83 e8 08             	sub    $0x8,%eax
    191c:	89 45 f8             	mov    %eax,-0x8(%ebp)
    191f:	a1 40 1e 00 00       	mov    0x1e40,%eax
    1924:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1927:	eb 24                	jmp    194d <free+0x3d>
    1929:	8b 45 fc             	mov    -0x4(%ebp),%eax
    192c:	8b 00                	mov    (%eax),%eax
    192e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1931:	77 12                	ja     1945 <free+0x35>
    1933:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1936:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1939:	77 24                	ja     195f <free+0x4f>
    193b:	8b 45 fc             	mov    -0x4(%ebp),%eax
    193e:	8b 00                	mov    (%eax),%eax
    1940:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1943:	77 1a                	ja     195f <free+0x4f>
    1945:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1948:	8b 00                	mov    (%eax),%eax
    194a:	89 45 fc             	mov    %eax,-0x4(%ebp)
    194d:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1950:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1953:	76 d4                	jbe    1929 <free+0x19>
    1955:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1958:	8b 00                	mov    (%eax),%eax
    195a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    195d:	76 ca                	jbe    1929 <free+0x19>
    195f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1962:	8b 40 04             	mov    0x4(%eax),%eax
    1965:	c1 e0 03             	shl    $0x3,%eax
    1968:	89 c2                	mov    %eax,%edx
    196a:	03 55 f8             	add    -0x8(%ebp),%edx
    196d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1970:	8b 00                	mov    (%eax),%eax
    1972:	39 c2                	cmp    %eax,%edx
    1974:	75 24                	jne    199a <free+0x8a>
    1976:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1979:	8b 50 04             	mov    0x4(%eax),%edx
    197c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    197f:	8b 00                	mov    (%eax),%eax
    1981:	8b 40 04             	mov    0x4(%eax),%eax
    1984:	01 c2                	add    %eax,%edx
    1986:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1989:	89 50 04             	mov    %edx,0x4(%eax)
    198c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    198f:	8b 00                	mov    (%eax),%eax
    1991:	8b 10                	mov    (%eax),%edx
    1993:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1996:	89 10                	mov    %edx,(%eax)
    1998:	eb 0a                	jmp    19a4 <free+0x94>
    199a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    199d:	8b 10                	mov    (%eax),%edx
    199f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    19a2:	89 10                	mov    %edx,(%eax)
    19a4:	8b 45 fc             	mov    -0x4(%ebp),%eax
    19a7:	8b 40 04             	mov    0x4(%eax),%eax
    19aa:	c1 e0 03             	shl    $0x3,%eax
    19ad:	03 45 fc             	add    -0x4(%ebp),%eax
    19b0:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    19b3:	75 20                	jne    19d5 <free+0xc5>
    19b5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    19b8:	8b 50 04             	mov    0x4(%eax),%edx
    19bb:	8b 45 f8             	mov    -0x8(%ebp),%eax
    19be:	8b 40 04             	mov    0x4(%eax),%eax
    19c1:	01 c2                	add    %eax,%edx
    19c3:	8b 45 fc             	mov    -0x4(%ebp),%eax
    19c6:	89 50 04             	mov    %edx,0x4(%eax)
    19c9:	8b 45 f8             	mov    -0x8(%ebp),%eax
    19cc:	8b 10                	mov    (%eax),%edx
    19ce:	8b 45 fc             	mov    -0x4(%ebp),%eax
    19d1:	89 10                	mov    %edx,(%eax)
    19d3:	eb 08                	jmp    19dd <free+0xcd>
    19d5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    19d8:	8b 55 f8             	mov    -0x8(%ebp),%edx
    19db:	89 10                	mov    %edx,(%eax)
    19dd:	8b 45 fc             	mov    -0x4(%ebp),%eax
    19e0:	a3 40 1e 00 00       	mov    %eax,0x1e40
    19e5:	c9                   	leave  
    19e6:	c3                   	ret    

000019e7 <morecore>:
    19e7:	55                   	push   %ebp
    19e8:	89 e5                	mov    %esp,%ebp
    19ea:	83 ec 28             	sub    $0x28,%esp
    19ed:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    19f4:	77 07                	ja     19fd <morecore+0x16>
    19f6:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
    19fd:	8b 45 08             	mov    0x8(%ebp),%eax
    1a00:	c1 e0 03             	shl    $0x3,%eax
    1a03:	89 04 24             	mov    %eax,(%esp)
    1a06:	e8 35 fc ff ff       	call   1640 <sbrk>
    1a0b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1a0e:	83 7d f0 ff          	cmpl   $0xffffffff,-0x10(%ebp)
    1a12:	75 07                	jne    1a1b <morecore+0x34>
    1a14:	b8 00 00 00 00       	mov    $0x0,%eax
    1a19:	eb 22                	jmp    1a3d <morecore+0x56>
    1a1b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a1e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1a21:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a24:	8b 55 08             	mov    0x8(%ebp),%edx
    1a27:	89 50 04             	mov    %edx,0x4(%eax)
    1a2a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a2d:	83 c0 08             	add    $0x8,%eax
    1a30:	89 04 24             	mov    %eax,(%esp)
    1a33:	e8 d8 fe ff ff       	call   1910 <free>
    1a38:	a1 40 1e 00 00       	mov    0x1e40,%eax
    1a3d:	c9                   	leave  
    1a3e:	c3                   	ret    

00001a3f <malloc>:
    1a3f:	55                   	push   %ebp
    1a40:	89 e5                	mov    %esp,%ebp
    1a42:	83 ec 28             	sub    $0x28,%esp
    1a45:	8b 45 08             	mov    0x8(%ebp),%eax
    1a48:	83 c0 07             	add    $0x7,%eax
    1a4b:	c1 e8 03             	shr    $0x3,%eax
    1a4e:	83 c0 01             	add    $0x1,%eax
    1a51:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1a54:	a1 40 1e 00 00       	mov    0x1e40,%eax
    1a59:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1a5c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1a60:	75 23                	jne    1a85 <malloc+0x46>
    1a62:	c7 45 f0 38 1e 00 00 	movl   $0x1e38,-0x10(%ebp)
    1a69:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a6c:	a3 40 1e 00 00       	mov    %eax,0x1e40
    1a71:	a1 40 1e 00 00       	mov    0x1e40,%eax
    1a76:	a3 38 1e 00 00       	mov    %eax,0x1e38
    1a7b:	c7 05 3c 1e 00 00 00 	movl   $0x0,0x1e3c
    1a82:	00 00 00 
    1a85:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a88:	8b 00                	mov    (%eax),%eax
    1a8a:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1a8d:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1a90:	8b 40 04             	mov    0x4(%eax),%eax
    1a93:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1a96:	72 4d                	jb     1ae5 <malloc+0xa6>
    1a98:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1a9b:	8b 40 04             	mov    0x4(%eax),%eax
    1a9e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1aa1:	75 0c                	jne    1aaf <malloc+0x70>
    1aa3:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1aa6:	8b 10                	mov    (%eax),%edx
    1aa8:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1aab:	89 10                	mov    %edx,(%eax)
    1aad:	eb 26                	jmp    1ad5 <malloc+0x96>
    1aaf:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1ab2:	8b 40 04             	mov    0x4(%eax),%eax
    1ab5:	89 c2                	mov    %eax,%edx
    1ab7:	2b 55 f4             	sub    -0xc(%ebp),%edx
    1aba:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1abd:	89 50 04             	mov    %edx,0x4(%eax)
    1ac0:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1ac3:	8b 40 04             	mov    0x4(%eax),%eax
    1ac6:	c1 e0 03             	shl    $0x3,%eax
    1ac9:	01 45 ec             	add    %eax,-0x14(%ebp)
    1acc:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1acf:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1ad2:	89 50 04             	mov    %edx,0x4(%eax)
    1ad5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1ad8:	a3 40 1e 00 00       	mov    %eax,0x1e40
    1add:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1ae0:	83 c0 08             	add    $0x8,%eax
    1ae3:	eb 38                	jmp    1b1d <malloc+0xde>
    1ae5:	a1 40 1e 00 00       	mov    0x1e40,%eax
    1aea:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    1aed:	75 1b                	jne    1b0a <malloc+0xcb>
    1aef:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1af2:	89 04 24             	mov    %eax,(%esp)
    1af5:	e8 ed fe ff ff       	call   19e7 <morecore>
    1afa:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1afd:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1b01:	75 07                	jne    1b0a <malloc+0xcb>
    1b03:	b8 00 00 00 00       	mov    $0x0,%eax
    1b08:	eb 13                	jmp    1b1d <malloc+0xde>
    1b0a:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1b0d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1b10:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1b13:	8b 00                	mov    (%eax),%eax
    1b15:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1b18:	e9 70 ff ff ff       	jmp    1a8d <malloc+0x4e>
    1b1d:	c9                   	leave  
    1b1e:	c3                   	ret    
    1b1f:	90                   	nop

00001b20 <xchg>:
    1b20:	55                   	push   %ebp
    1b21:	89 e5                	mov    %esp,%ebp
    1b23:	83 ec 10             	sub    $0x10,%esp
    1b26:	8b 55 08             	mov    0x8(%ebp),%edx
    1b29:	8b 45 0c             	mov    0xc(%ebp),%eax
    1b2c:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1b2f:	f0 87 02             	lock xchg %eax,(%edx)
    1b32:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1b35:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1b38:	c9                   	leave  
    1b39:	c3                   	ret    

00001b3a <lock_init>:
    1b3a:	55                   	push   %ebp
    1b3b:	89 e5                	mov    %esp,%ebp
    1b3d:	8b 45 08             	mov    0x8(%ebp),%eax
    1b40:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    1b46:	5d                   	pop    %ebp
    1b47:	c3                   	ret    

00001b48 <lock_acquire>:
    1b48:	55                   	push   %ebp
    1b49:	89 e5                	mov    %esp,%ebp
    1b4b:	83 ec 08             	sub    $0x8,%esp
    1b4e:	8b 45 08             	mov    0x8(%ebp),%eax
    1b51:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    1b58:	00 
    1b59:	89 04 24             	mov    %eax,(%esp)
    1b5c:	e8 bf ff ff ff       	call   1b20 <xchg>
    1b61:	85 c0                	test   %eax,%eax
    1b63:	75 e9                	jne    1b4e <lock_acquire+0x6>
    1b65:	c9                   	leave  
    1b66:	c3                   	ret    

00001b67 <lock_release>:
    1b67:	55                   	push   %ebp
    1b68:	89 e5                	mov    %esp,%ebp
    1b6a:	83 ec 08             	sub    $0x8,%esp
    1b6d:	8b 45 08             	mov    0x8(%ebp),%eax
    1b70:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1b77:	00 
    1b78:	89 04 24             	mov    %eax,(%esp)
    1b7b:	e8 a0 ff ff ff       	call   1b20 <xchg>
    1b80:	c9                   	leave  
    1b81:	c3                   	ret    

00001b82 <thread_create>:
    1b82:	55                   	push   %ebp
    1b83:	89 e5                	mov    %esp,%ebp
    1b85:	83 ec 28             	sub    $0x28,%esp
    1b88:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    1b8f:	e8 ab fe ff ff       	call   1a3f <malloc>
    1b94:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1b97:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1b9a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1b9d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1ba0:	25 ff 0f 00 00       	and    $0xfff,%eax
    1ba5:	85 c0                	test   %eax,%eax
    1ba7:	74 15                	je     1bbe <thread_create+0x3c>
    1ba9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1bac:	89 c2                	mov    %eax,%edx
    1bae:	81 e2 ff 0f 00 00    	and    $0xfff,%edx
    1bb4:	b8 00 10 00 00       	mov    $0x1000,%eax
    1bb9:	29 d0                	sub    %edx,%eax
    1bbb:	01 45 f0             	add    %eax,-0x10(%ebp)
    1bbe:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1bc2:	75 1b                	jne    1bdf <thread_create+0x5d>
    1bc4:	c7 44 24 04 e2 1d 00 	movl   $0x1de2,0x4(%esp)
    1bcb:	00 
    1bcc:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1bd3:	e8 81 fb ff ff       	call   1759 <printf>
    1bd8:	b8 00 00 00 00       	mov    $0x0,%eax
    1bdd:	eb 6f                	jmp    1c4e <thread_create+0xcc>
    1bdf:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1be2:	8b 55 08             	mov    0x8(%ebp),%edx
    1be5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1be8:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    1bec:	89 54 24 08          	mov    %edx,0x8(%esp)
    1bf0:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    1bf7:	00 
    1bf8:	89 04 24             	mov    %eax,(%esp)
    1bfb:	e8 58 fa ff ff       	call   1658 <clone>
    1c00:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1c03:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1c07:	79 1b                	jns    1c24 <thread_create+0xa2>
    1c09:	c7 44 24 04 f0 1d 00 	movl   $0x1df0,0x4(%esp)
    1c10:	00 
    1c11:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1c18:	e8 3c fb ff ff       	call   1759 <printf>
    1c1d:	b8 00 00 00 00       	mov    $0x0,%eax
    1c22:	eb 2a                	jmp    1c4e <thread_create+0xcc>
    1c24:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1c28:	7e 05                	jle    1c2f <thread_create+0xad>
    1c2a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c2d:	eb 1f                	jmp    1c4e <thread_create+0xcc>
    1c2f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1c33:	75 14                	jne    1c49 <thread_create+0xc7>
    1c35:	c7 44 24 04 fd 1d 00 	movl   $0x1dfd,0x4(%esp)
    1c3c:	00 
    1c3d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1c44:	e8 10 fb ff ff       	call   1759 <printf>
    1c49:	b8 00 00 00 00       	mov    $0x0,%eax
    1c4e:	c9                   	leave  
    1c4f:	c3                   	ret    

00001c50 <random>:
    1c50:	55                   	push   %ebp
    1c51:	89 e5                	mov    %esp,%ebp
    1c53:	a1 24 1e 00 00       	mov    0x1e24,%eax
    1c58:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    1c5e:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
    1c63:	a3 24 1e 00 00       	mov    %eax,0x1e24
    1c68:	a1 24 1e 00 00       	mov    0x1e24,%eax
    1c6d:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1c70:	ba 00 00 00 00       	mov    $0x0,%edx
    1c75:	f7 f1                	div    %ecx
    1c77:	89 d0                	mov    %edx,%eax
    1c79:	5d                   	pop    %ebp
    1c7a:	c3                   	ret    
    1c7b:	90                   	nop

00001c7c <init_q>:
    1c7c:	55                   	push   %ebp
    1c7d:	89 e5                	mov    %esp,%ebp
    1c7f:	8b 45 08             	mov    0x8(%ebp),%eax
    1c82:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    1c88:	8b 45 08             	mov    0x8(%ebp),%eax
    1c8b:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    1c92:	8b 45 08             	mov    0x8(%ebp),%eax
    1c95:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
    1c9c:	5d                   	pop    %ebp
    1c9d:	c3                   	ret    

00001c9e <add_q>:
    1c9e:	55                   	push   %ebp
    1c9f:	89 e5                	mov    %esp,%ebp
    1ca1:	83 ec 28             	sub    $0x28,%esp
    1ca4:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    1cab:	e8 8f fd ff ff       	call   1a3f <malloc>
    1cb0:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1cb3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1cb6:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    1cbd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1cc0:	8b 55 0c             	mov    0xc(%ebp),%edx
    1cc3:	89 10                	mov    %edx,(%eax)
    1cc5:	8b 45 08             	mov    0x8(%ebp),%eax
    1cc8:	8b 40 04             	mov    0x4(%eax),%eax
    1ccb:	85 c0                	test   %eax,%eax
    1ccd:	75 0b                	jne    1cda <add_q+0x3c>
    1ccf:	8b 45 08             	mov    0x8(%ebp),%eax
    1cd2:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1cd5:	89 50 04             	mov    %edx,0x4(%eax)
    1cd8:	eb 0c                	jmp    1ce6 <add_q+0x48>
    1cda:	8b 45 08             	mov    0x8(%ebp),%eax
    1cdd:	8b 40 08             	mov    0x8(%eax),%eax
    1ce0:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1ce3:	89 50 04             	mov    %edx,0x4(%eax)
    1ce6:	8b 45 08             	mov    0x8(%ebp),%eax
    1ce9:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1cec:	89 50 08             	mov    %edx,0x8(%eax)
    1cef:	8b 45 08             	mov    0x8(%ebp),%eax
    1cf2:	8b 00                	mov    (%eax),%eax
    1cf4:	8d 50 01             	lea    0x1(%eax),%edx
    1cf7:	8b 45 08             	mov    0x8(%ebp),%eax
    1cfa:	89 10                	mov    %edx,(%eax)
    1cfc:	c9                   	leave  
    1cfd:	c3                   	ret    

00001cfe <empty_q>:
    1cfe:	55                   	push   %ebp
    1cff:	89 e5                	mov    %esp,%ebp
    1d01:	8b 45 08             	mov    0x8(%ebp),%eax
    1d04:	8b 00                	mov    (%eax),%eax
    1d06:	85 c0                	test   %eax,%eax
    1d08:	75 07                	jne    1d11 <empty_q+0x13>
    1d0a:	b8 01 00 00 00       	mov    $0x1,%eax
    1d0f:	eb 05                	jmp    1d16 <empty_q+0x18>
    1d11:	b8 00 00 00 00       	mov    $0x0,%eax
    1d16:	5d                   	pop    %ebp
    1d17:	c3                   	ret    

00001d18 <pop_q>:
    1d18:	55                   	push   %ebp
    1d19:	89 e5                	mov    %esp,%ebp
    1d1b:	83 ec 28             	sub    $0x28,%esp
    1d1e:	8b 45 08             	mov    0x8(%ebp),%eax
    1d21:	89 04 24             	mov    %eax,(%esp)
    1d24:	e8 d5 ff ff ff       	call   1cfe <empty_q>
    1d29:	85 c0                	test   %eax,%eax
    1d2b:	75 5d                	jne    1d8a <pop_q+0x72>
    1d2d:	8b 45 08             	mov    0x8(%ebp),%eax
    1d30:	8b 40 04             	mov    0x4(%eax),%eax
    1d33:	8b 00                	mov    (%eax),%eax
    1d35:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1d38:	8b 45 08             	mov    0x8(%ebp),%eax
    1d3b:	8b 40 04             	mov    0x4(%eax),%eax
    1d3e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1d41:	8b 45 08             	mov    0x8(%ebp),%eax
    1d44:	8b 40 04             	mov    0x4(%eax),%eax
    1d47:	8b 50 04             	mov    0x4(%eax),%edx
    1d4a:	8b 45 08             	mov    0x8(%ebp),%eax
    1d4d:	89 50 04             	mov    %edx,0x4(%eax)
    1d50:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1d53:	89 04 24             	mov    %eax,(%esp)
    1d56:	e8 b5 fb ff ff       	call   1910 <free>
    1d5b:	8b 45 08             	mov    0x8(%ebp),%eax
    1d5e:	8b 00                	mov    (%eax),%eax
    1d60:	8d 50 ff             	lea    -0x1(%eax),%edx
    1d63:	8b 45 08             	mov    0x8(%ebp),%eax
    1d66:	89 10                	mov    %edx,(%eax)
    1d68:	8b 45 08             	mov    0x8(%ebp),%eax
    1d6b:	8b 00                	mov    (%eax),%eax
    1d6d:	85 c0                	test   %eax,%eax
    1d6f:	75 14                	jne    1d85 <pop_q+0x6d>
    1d71:	8b 45 08             	mov    0x8(%ebp),%eax
    1d74:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    1d7b:	8b 45 08             	mov    0x8(%ebp),%eax
    1d7e:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
    1d85:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1d88:	eb 05                	jmp    1d8f <pop_q+0x77>
    1d8a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1d8f:	c9                   	leave  
    1d90:	c3                   	ret    
