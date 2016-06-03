
_tyield:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:
void one(void * arg_ptr);
void two(void * arg_ptr);

int i;

int main(){
    1000:	55                   	push   %ebp
    1001:	89 e5                	mov    %esp,%ebp
    1003:	83 e4 f0             	and    $0xfffffff0,%esp
    1006:	83 ec 20             	sub    $0x20,%esp
  int arg = 10;
    1009:	c7 44 24 18 0a 00 00 	movl   $0xa,0x18(%esp)
    1010:	00 
  void *tid;

	tid = thread_create(one, (void *) &arg);
    1011:	8d 44 24 18          	lea    0x18(%esp),%eax
    1015:	89 44 24 04          	mov    %eax,0x4(%esp)
    1019:	c7 04 24 d9 10 00 00 	movl   $0x10d9,(%esp)
    1020:	e8 99 09 00 00       	call   19be <thread_create>
    1025:	89 44 24 1c          	mov    %eax,0x1c(%esp)
	if(tid <= 0){
    1029:	83 7c 24 1c 00       	cmpl   $0x0,0x1c(%esp)
    102e:	75 19                	jne    1049 <main+0x49>
		printf(1, "Thread Creation Failed\n");
    1030:	c7 44 24 04 cd 1b 00 	movl   $0x1bcd,0x4(%esp)
    1037:	00 
    1038:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    103f:	e8 51 05 00 00       	call   1595 <printf>
		exit();
    1044:	e8 ab 03 00 00       	call   13f4 <exit>
	}
	for(i = 0; i < 2999999; i++);
    1049:	c7 05 54 1c 00 00 00 	movl   $0x0,0x1c54
    1050:	00 00 00 
    1053:	eb 0d                	jmp    1062 <main+0x62>
    1055:	a1 54 1c 00 00       	mov    0x1c54,%eax
    105a:	83 c0 01             	add    $0x1,%eax
    105d:	a3 54 1c 00 00       	mov    %eax,0x1c54
    1062:	a1 54 1c 00 00       	mov    0x1c54,%eax
    1067:	3d be c6 2d 00       	cmp    $0x2dc6be,%eax
    106c:	7e e7                	jle    1055 <main+0x55>
	tid = thread_create(two, (void *) &arg);
    106e:	8d 44 24 18          	lea    0x18(%esp),%eax
    1072:	89 44 24 04          	mov    %eax,0x4(%esp)
    1076:	c7 04 24 34 11 00 00 	movl   $0x1134,(%esp)
    107d:	e8 3c 09 00 00       	call   19be <thread_create>
    1082:	89 44 24 1c          	mov    %eax,0x1c(%esp)
	if(tid <= 0){
    1086:	83 7c 24 1c 00       	cmpl   $0x0,0x1c(%esp)
    108b:	75 19                	jne    10a6 <main+0xa6>
		printf(1, "Thread Creation Failed\n");
    108d:	c7 44 24 04 cd 1b 00 	movl   $0x1bcd,0x4(%esp)
    1094:	00 
    1095:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    109c:	e8 f4 04 00 00       	call   1595 <printf>
		exit();
    10a1:	e8 4e 03 00 00       	call   13f4 <exit>
	}
	for(i = 0; i < 2999999; i++);
    10a6:	c7 05 54 1c 00 00 00 	movl   $0x0,0x1c54
    10ad:	00 00 00 
    10b0:	eb 0d                	jmp    10bf <main+0xbf>
    10b2:	a1 54 1c 00 00       	mov    0x1c54,%eax
    10b7:	83 c0 01             	add    $0x1,%eax
    10ba:	a3 54 1c 00 00       	mov    %eax,0x1c54
    10bf:	a1 54 1c 00 00       	mov    0x1c54,%eax
    10c4:	3d be c6 2d 00       	cmp    $0x2dc6be,%eax
    10c9:	7e e7                	jle    10b2 <main+0xb2>
  while(wait()>=0);
    10cb:	e8 2c 03 00 00       	call   13fc <wait>
    10d0:	85 c0                	test   %eax,%eax
    10d2:	79 f7                	jns    10cb <main+0xcb>

  exit();
    10d4:	e8 1b 03 00 00       	call   13f4 <exit>

000010d9 <one>:
  return 0;
}

// Beep
void one(void *arg_ptr){
    10d9:	55                   	push   %ebp
    10da:	89 e5                	mov    %esp,%ebp
    10dc:	83 ec 18             	sub    $0x18,%esp
	for(i = 0; i < 20; i++){
    10df:	c7 05 54 1c 00 00 00 	movl   $0x0,0x1c54
    10e6:	00 00 00 
    10e9:	eb 3a                	jmp    1125 <one+0x4c>
		printf(1, "fdaaa\n");
    10eb:	c7 44 24 04 e5 1b 00 	movl   $0x1be5,0x4(%esp)
    10f2:	00 
    10f3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    10fa:	e8 96 04 00 00       	call   1595 <printf>
		thread_yield();
    10ff:	e8 b0 03 00 00       	call   14b4 <thread_yield>
		printf(1, "one\n");
    1104:	c7 44 24 04 ec 1b 00 	movl   $0x1bec,0x4(%esp)
    110b:	00 
    110c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1113:	e8 7d 04 00 00       	call   1595 <printf>
  return 0;
}

// Beep
void one(void *arg_ptr){
	for(i = 0; i < 20; i++){
    1118:	a1 54 1c 00 00       	mov    0x1c54,%eax
    111d:	83 c0 01             	add    $0x1,%eax
    1120:	a3 54 1c 00 00       	mov    %eax,0x1c54
    1125:	a1 54 1c 00 00       	mov    0x1c54,%eax
    112a:	83 f8 13             	cmp    $0x13,%eax
    112d:	7e bc                	jle    10eb <one+0x12>
		printf(1, "fdaaa\n");
		thread_yield();
		printf(1, "one\n");
	}
  texit();
    112f:	e8 68 03 00 00       	call   149c <texit>

00001134 <two>:
}

// Boop
void two(void *arg_ptr){
    1134:	55                   	push   %ebp
    1135:	89 e5                	mov    %esp,%ebp
    1137:	83 ec 18             	sub    $0x18,%esp
	for(i = 0; i < 20; i++){
    113a:	c7 05 54 1c 00 00 00 	movl   $0x0,0x1c54
    1141:	00 00 00 
    1144:	eb 3a                	jmp    1180 <two+0x4c>
		printf(1, "gfsd\n");
    1146:	c7 44 24 04 f1 1b 00 	movl   $0x1bf1,0x4(%esp)
    114d:	00 
    114e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1155:	e8 3b 04 00 00       	call   1595 <printf>
		thread_yield();
    115a:	e8 55 03 00 00       	call   14b4 <thread_yield>
		printf(1, "two\n");
    115f:	c7 44 24 04 f7 1b 00 	movl   $0x1bf7,0x4(%esp)
    1166:	00 
    1167:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    116e:	e8 22 04 00 00       	call   1595 <printf>
  texit();
}

// Boop
void two(void *arg_ptr){
	for(i = 0; i < 20; i++){
    1173:	a1 54 1c 00 00       	mov    0x1c54,%eax
    1178:	83 c0 01             	add    $0x1,%eax
    117b:	a3 54 1c 00 00       	mov    %eax,0x1c54
    1180:	a1 54 1c 00 00       	mov    0x1c54,%eax
    1185:	83 f8 13             	cmp    $0x13,%eax
    1188:	7e bc                	jle    1146 <two+0x12>
		printf(1, "gfsd\n");
		thread_yield();
		printf(1, "two\n");
	}
  texit();
    118a:	e8 0d 03 00 00       	call   149c <texit>
    118f:	90                   	nop

00001190 <stosb>:
    1190:	55                   	push   %ebp
    1191:	89 e5                	mov    %esp,%ebp
    1193:	57                   	push   %edi
    1194:	53                   	push   %ebx
    1195:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1198:	8b 55 10             	mov    0x10(%ebp),%edx
    119b:	8b 45 0c             	mov    0xc(%ebp),%eax
    119e:	89 cb                	mov    %ecx,%ebx
    11a0:	89 df                	mov    %ebx,%edi
    11a2:	89 d1                	mov    %edx,%ecx
    11a4:	fc                   	cld    
    11a5:	f3 aa                	rep stos %al,%es:(%edi)
    11a7:	89 ca                	mov    %ecx,%edx
    11a9:	89 fb                	mov    %edi,%ebx
    11ab:	89 5d 08             	mov    %ebx,0x8(%ebp)
    11ae:	89 55 10             	mov    %edx,0x10(%ebp)
    11b1:	5b                   	pop    %ebx
    11b2:	5f                   	pop    %edi
    11b3:	5d                   	pop    %ebp
    11b4:	c3                   	ret    

000011b5 <strcpy>:
    11b5:	55                   	push   %ebp
    11b6:	89 e5                	mov    %esp,%ebp
    11b8:	83 ec 10             	sub    $0x10,%esp
    11bb:	8b 45 08             	mov    0x8(%ebp),%eax
    11be:	89 45 fc             	mov    %eax,-0x4(%ebp)
    11c1:	8b 45 0c             	mov    0xc(%ebp),%eax
    11c4:	0f b6 10             	movzbl (%eax),%edx
    11c7:	8b 45 08             	mov    0x8(%ebp),%eax
    11ca:	88 10                	mov    %dl,(%eax)
    11cc:	8b 45 08             	mov    0x8(%ebp),%eax
    11cf:	0f b6 00             	movzbl (%eax),%eax
    11d2:	84 c0                	test   %al,%al
    11d4:	0f 95 c0             	setne  %al
    11d7:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    11db:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    11df:	84 c0                	test   %al,%al
    11e1:	75 de                	jne    11c1 <strcpy+0xc>
    11e3:	8b 45 fc             	mov    -0x4(%ebp),%eax
    11e6:	c9                   	leave  
    11e7:	c3                   	ret    

000011e8 <strcmp>:
    11e8:	55                   	push   %ebp
    11e9:	89 e5                	mov    %esp,%ebp
    11eb:	eb 08                	jmp    11f5 <strcmp+0xd>
    11ed:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    11f1:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    11f5:	8b 45 08             	mov    0x8(%ebp),%eax
    11f8:	0f b6 00             	movzbl (%eax),%eax
    11fb:	84 c0                	test   %al,%al
    11fd:	74 10                	je     120f <strcmp+0x27>
    11ff:	8b 45 08             	mov    0x8(%ebp),%eax
    1202:	0f b6 10             	movzbl (%eax),%edx
    1205:	8b 45 0c             	mov    0xc(%ebp),%eax
    1208:	0f b6 00             	movzbl (%eax),%eax
    120b:	38 c2                	cmp    %al,%dl
    120d:	74 de                	je     11ed <strcmp+0x5>
    120f:	8b 45 08             	mov    0x8(%ebp),%eax
    1212:	0f b6 00             	movzbl (%eax),%eax
    1215:	0f b6 d0             	movzbl %al,%edx
    1218:	8b 45 0c             	mov    0xc(%ebp),%eax
    121b:	0f b6 00             	movzbl (%eax),%eax
    121e:	0f b6 c0             	movzbl %al,%eax
    1221:	89 d1                	mov    %edx,%ecx
    1223:	29 c1                	sub    %eax,%ecx
    1225:	89 c8                	mov    %ecx,%eax
    1227:	5d                   	pop    %ebp
    1228:	c3                   	ret    

00001229 <strlen>:
    1229:	55                   	push   %ebp
    122a:	89 e5                	mov    %esp,%ebp
    122c:	83 ec 10             	sub    $0x10,%esp
    122f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    1236:	eb 04                	jmp    123c <strlen+0x13>
    1238:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    123c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    123f:	03 45 08             	add    0x8(%ebp),%eax
    1242:	0f b6 00             	movzbl (%eax),%eax
    1245:	84 c0                	test   %al,%al
    1247:	75 ef                	jne    1238 <strlen+0xf>
    1249:	8b 45 fc             	mov    -0x4(%ebp),%eax
    124c:	c9                   	leave  
    124d:	c3                   	ret    

0000124e <memset>:
    124e:	55                   	push   %ebp
    124f:	89 e5                	mov    %esp,%ebp
    1251:	83 ec 0c             	sub    $0xc,%esp
    1254:	8b 45 10             	mov    0x10(%ebp),%eax
    1257:	89 44 24 08          	mov    %eax,0x8(%esp)
    125b:	8b 45 0c             	mov    0xc(%ebp),%eax
    125e:	89 44 24 04          	mov    %eax,0x4(%esp)
    1262:	8b 45 08             	mov    0x8(%ebp),%eax
    1265:	89 04 24             	mov    %eax,(%esp)
    1268:	e8 23 ff ff ff       	call   1190 <stosb>
    126d:	8b 45 08             	mov    0x8(%ebp),%eax
    1270:	c9                   	leave  
    1271:	c3                   	ret    

00001272 <strchr>:
    1272:	55                   	push   %ebp
    1273:	89 e5                	mov    %esp,%ebp
    1275:	83 ec 04             	sub    $0x4,%esp
    1278:	8b 45 0c             	mov    0xc(%ebp),%eax
    127b:	88 45 fc             	mov    %al,-0x4(%ebp)
    127e:	eb 14                	jmp    1294 <strchr+0x22>
    1280:	8b 45 08             	mov    0x8(%ebp),%eax
    1283:	0f b6 00             	movzbl (%eax),%eax
    1286:	3a 45 fc             	cmp    -0x4(%ebp),%al
    1289:	75 05                	jne    1290 <strchr+0x1e>
    128b:	8b 45 08             	mov    0x8(%ebp),%eax
    128e:	eb 13                	jmp    12a3 <strchr+0x31>
    1290:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1294:	8b 45 08             	mov    0x8(%ebp),%eax
    1297:	0f b6 00             	movzbl (%eax),%eax
    129a:	84 c0                	test   %al,%al
    129c:	75 e2                	jne    1280 <strchr+0xe>
    129e:	b8 00 00 00 00       	mov    $0x0,%eax
    12a3:	c9                   	leave  
    12a4:	c3                   	ret    

000012a5 <gets>:
    12a5:	55                   	push   %ebp
    12a6:	89 e5                	mov    %esp,%ebp
    12a8:	83 ec 28             	sub    $0x28,%esp
    12ab:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    12b2:	eb 44                	jmp    12f8 <gets+0x53>
    12b4:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    12bb:	00 
    12bc:	8d 45 ef             	lea    -0x11(%ebp),%eax
    12bf:	89 44 24 04          	mov    %eax,0x4(%esp)
    12c3:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    12ca:	e8 3d 01 00 00       	call   140c <read>
    12cf:	89 45 f4             	mov    %eax,-0xc(%ebp)
    12d2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    12d6:	7e 2d                	jle    1305 <gets+0x60>
    12d8:	8b 45 f0             	mov    -0x10(%ebp),%eax
    12db:	03 45 08             	add    0x8(%ebp),%eax
    12de:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
    12e2:	88 10                	mov    %dl,(%eax)
    12e4:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    12e8:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    12ec:	3c 0a                	cmp    $0xa,%al
    12ee:	74 16                	je     1306 <gets+0x61>
    12f0:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    12f4:	3c 0d                	cmp    $0xd,%al
    12f6:	74 0e                	je     1306 <gets+0x61>
    12f8:	8b 45 f0             	mov    -0x10(%ebp),%eax
    12fb:	83 c0 01             	add    $0x1,%eax
    12fe:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1301:	7c b1                	jl     12b4 <gets+0xf>
    1303:	eb 01                	jmp    1306 <gets+0x61>
    1305:	90                   	nop
    1306:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1309:	03 45 08             	add    0x8(%ebp),%eax
    130c:	c6 00 00             	movb   $0x0,(%eax)
    130f:	8b 45 08             	mov    0x8(%ebp),%eax
    1312:	c9                   	leave  
    1313:	c3                   	ret    

00001314 <stat>:
    1314:	55                   	push   %ebp
    1315:	89 e5                	mov    %esp,%ebp
    1317:	83 ec 28             	sub    $0x28,%esp
    131a:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1321:	00 
    1322:	8b 45 08             	mov    0x8(%ebp),%eax
    1325:	89 04 24             	mov    %eax,(%esp)
    1328:	e8 07 01 00 00       	call   1434 <open>
    132d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1330:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1334:	79 07                	jns    133d <stat+0x29>
    1336:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    133b:	eb 23                	jmp    1360 <stat+0x4c>
    133d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1340:	89 44 24 04          	mov    %eax,0x4(%esp)
    1344:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1347:	89 04 24             	mov    %eax,(%esp)
    134a:	e8 fd 00 00 00       	call   144c <fstat>
    134f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1352:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1355:	89 04 24             	mov    %eax,(%esp)
    1358:	e8 bf 00 00 00       	call   141c <close>
    135d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1360:	c9                   	leave  
    1361:	c3                   	ret    

00001362 <atoi>:
    1362:	55                   	push   %ebp
    1363:	89 e5                	mov    %esp,%ebp
    1365:	83 ec 10             	sub    $0x10,%esp
    1368:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    136f:	eb 24                	jmp    1395 <atoi+0x33>
    1371:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1374:	89 d0                	mov    %edx,%eax
    1376:	c1 e0 02             	shl    $0x2,%eax
    1379:	01 d0                	add    %edx,%eax
    137b:	01 c0                	add    %eax,%eax
    137d:	89 c2                	mov    %eax,%edx
    137f:	8b 45 08             	mov    0x8(%ebp),%eax
    1382:	0f b6 00             	movzbl (%eax),%eax
    1385:	0f be c0             	movsbl %al,%eax
    1388:	8d 04 02             	lea    (%edx,%eax,1),%eax
    138b:	83 e8 30             	sub    $0x30,%eax
    138e:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1391:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1395:	8b 45 08             	mov    0x8(%ebp),%eax
    1398:	0f b6 00             	movzbl (%eax),%eax
    139b:	3c 2f                	cmp    $0x2f,%al
    139d:	7e 0a                	jle    13a9 <atoi+0x47>
    139f:	8b 45 08             	mov    0x8(%ebp),%eax
    13a2:	0f b6 00             	movzbl (%eax),%eax
    13a5:	3c 39                	cmp    $0x39,%al
    13a7:	7e c8                	jle    1371 <atoi+0xf>
    13a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    13ac:	c9                   	leave  
    13ad:	c3                   	ret    

000013ae <memmove>:
    13ae:	55                   	push   %ebp
    13af:	89 e5                	mov    %esp,%ebp
    13b1:	83 ec 10             	sub    $0x10,%esp
    13b4:	8b 45 08             	mov    0x8(%ebp),%eax
    13b7:	89 45 f8             	mov    %eax,-0x8(%ebp)
    13ba:	8b 45 0c             	mov    0xc(%ebp),%eax
    13bd:	89 45 fc             	mov    %eax,-0x4(%ebp)
    13c0:	eb 13                	jmp    13d5 <memmove+0x27>
    13c2:	8b 45 fc             	mov    -0x4(%ebp),%eax
    13c5:	0f b6 10             	movzbl (%eax),%edx
    13c8:	8b 45 f8             	mov    -0x8(%ebp),%eax
    13cb:	88 10                	mov    %dl,(%eax)
    13cd:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    13d1:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    13d5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    13d9:	0f 9f c0             	setg   %al
    13dc:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    13e0:	84 c0                	test   %al,%al
    13e2:	75 de                	jne    13c2 <memmove+0x14>
    13e4:	8b 45 08             	mov    0x8(%ebp),%eax
    13e7:	c9                   	leave  
    13e8:	c3                   	ret    
    13e9:	90                   	nop
    13ea:	90                   	nop
    13eb:	90                   	nop

000013ec <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    13ec:	b8 01 00 00 00       	mov    $0x1,%eax
    13f1:	cd 40                	int    $0x40
    13f3:	c3                   	ret    

000013f4 <exit>:
SYSCALL(exit)
    13f4:	b8 02 00 00 00       	mov    $0x2,%eax
    13f9:	cd 40                	int    $0x40
    13fb:	c3                   	ret    

000013fc <wait>:
SYSCALL(wait)
    13fc:	b8 03 00 00 00       	mov    $0x3,%eax
    1401:	cd 40                	int    $0x40
    1403:	c3                   	ret    

00001404 <pipe>:
SYSCALL(pipe)
    1404:	b8 04 00 00 00       	mov    $0x4,%eax
    1409:	cd 40                	int    $0x40
    140b:	c3                   	ret    

0000140c <read>:
SYSCALL(read)
    140c:	b8 05 00 00 00       	mov    $0x5,%eax
    1411:	cd 40                	int    $0x40
    1413:	c3                   	ret    

00001414 <write>:
SYSCALL(write)
    1414:	b8 10 00 00 00       	mov    $0x10,%eax
    1419:	cd 40                	int    $0x40
    141b:	c3                   	ret    

0000141c <close>:
SYSCALL(close)
    141c:	b8 15 00 00 00       	mov    $0x15,%eax
    1421:	cd 40                	int    $0x40
    1423:	c3                   	ret    

00001424 <kill>:
SYSCALL(kill)
    1424:	b8 06 00 00 00       	mov    $0x6,%eax
    1429:	cd 40                	int    $0x40
    142b:	c3                   	ret    

0000142c <exec>:
SYSCALL(exec)
    142c:	b8 07 00 00 00       	mov    $0x7,%eax
    1431:	cd 40                	int    $0x40
    1433:	c3                   	ret    

00001434 <open>:
SYSCALL(open)
    1434:	b8 0f 00 00 00       	mov    $0xf,%eax
    1439:	cd 40                	int    $0x40
    143b:	c3                   	ret    

0000143c <mknod>:
SYSCALL(mknod)
    143c:	b8 11 00 00 00       	mov    $0x11,%eax
    1441:	cd 40                	int    $0x40
    1443:	c3                   	ret    

00001444 <unlink>:
SYSCALL(unlink)
    1444:	b8 12 00 00 00       	mov    $0x12,%eax
    1449:	cd 40                	int    $0x40
    144b:	c3                   	ret    

0000144c <fstat>:
SYSCALL(fstat)
    144c:	b8 08 00 00 00       	mov    $0x8,%eax
    1451:	cd 40                	int    $0x40
    1453:	c3                   	ret    

00001454 <link>:
SYSCALL(link)
    1454:	b8 13 00 00 00       	mov    $0x13,%eax
    1459:	cd 40                	int    $0x40
    145b:	c3                   	ret    

0000145c <mkdir>:
SYSCALL(mkdir)
    145c:	b8 14 00 00 00       	mov    $0x14,%eax
    1461:	cd 40                	int    $0x40
    1463:	c3                   	ret    

00001464 <chdir>:
SYSCALL(chdir)
    1464:	b8 09 00 00 00       	mov    $0x9,%eax
    1469:	cd 40                	int    $0x40
    146b:	c3                   	ret    

0000146c <dup>:
SYSCALL(dup)
    146c:	b8 0a 00 00 00       	mov    $0xa,%eax
    1471:	cd 40                	int    $0x40
    1473:	c3                   	ret    

00001474 <getpid>:
SYSCALL(getpid)
    1474:	b8 0b 00 00 00       	mov    $0xb,%eax
    1479:	cd 40                	int    $0x40
    147b:	c3                   	ret    

0000147c <sbrk>:
SYSCALL(sbrk)
    147c:	b8 0c 00 00 00       	mov    $0xc,%eax
    1481:	cd 40                	int    $0x40
    1483:	c3                   	ret    

00001484 <sleep>:
SYSCALL(sleep)
    1484:	b8 0d 00 00 00       	mov    $0xd,%eax
    1489:	cd 40                	int    $0x40
    148b:	c3                   	ret    

0000148c <uptime>:
SYSCALL(uptime)
    148c:	b8 0e 00 00 00       	mov    $0xe,%eax
    1491:	cd 40                	int    $0x40
    1493:	c3                   	ret    

00001494 <clone>:
SYSCALL(clone)
    1494:	b8 16 00 00 00       	mov    $0x16,%eax
    1499:	cd 40                	int    $0x40
    149b:	c3                   	ret    

0000149c <texit>:
SYSCALL(texit)
    149c:	b8 17 00 00 00       	mov    $0x17,%eax
    14a1:	cd 40                	int    $0x40
    14a3:	c3                   	ret    

000014a4 <tsleep>:
SYSCALL(tsleep)
    14a4:	b8 18 00 00 00       	mov    $0x18,%eax
    14a9:	cd 40                	int    $0x40
    14ab:	c3                   	ret    

000014ac <twakeup>:
SYSCALL(twakeup)
    14ac:	b8 19 00 00 00       	mov    $0x19,%eax
    14b1:	cd 40                	int    $0x40
    14b3:	c3                   	ret    

000014b4 <thread_yield>:
SYSCALL(thread_yield)
    14b4:	b8 1a 00 00 00       	mov    $0x1a,%eax
    14b9:	cd 40                	int    $0x40
    14bb:	c3                   	ret    

000014bc <putc>:
    14bc:	55                   	push   %ebp
    14bd:	89 e5                	mov    %esp,%ebp
    14bf:	83 ec 28             	sub    $0x28,%esp
    14c2:	8b 45 0c             	mov    0xc(%ebp),%eax
    14c5:	88 45 f4             	mov    %al,-0xc(%ebp)
    14c8:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    14cf:	00 
    14d0:	8d 45 f4             	lea    -0xc(%ebp),%eax
    14d3:	89 44 24 04          	mov    %eax,0x4(%esp)
    14d7:	8b 45 08             	mov    0x8(%ebp),%eax
    14da:	89 04 24             	mov    %eax,(%esp)
    14dd:	e8 32 ff ff ff       	call   1414 <write>
    14e2:	c9                   	leave  
    14e3:	c3                   	ret    

000014e4 <printint>:
    14e4:	55                   	push   %ebp
    14e5:	89 e5                	mov    %esp,%ebp
    14e7:	53                   	push   %ebx
    14e8:	83 ec 44             	sub    $0x44,%esp
    14eb:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    14f2:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    14f6:	74 17                	je     150f <printint+0x2b>
    14f8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    14fc:	79 11                	jns    150f <printint+0x2b>
    14fe:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    1505:	8b 45 0c             	mov    0xc(%ebp),%eax
    1508:	f7 d8                	neg    %eax
    150a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    150d:	eb 06                	jmp    1515 <printint+0x31>
    150f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1512:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1515:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    151c:	8b 4d ec             	mov    -0x14(%ebp),%ecx
    151f:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1522:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1525:	ba 00 00 00 00       	mov    $0x0,%edx
    152a:	f7 f3                	div    %ebx
    152c:	89 d0                	mov    %edx,%eax
    152e:	0f b6 80 30 1c 00 00 	movzbl 0x1c30(%eax),%eax
    1535:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
    1539:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    153d:	8b 45 10             	mov    0x10(%ebp),%eax
    1540:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    1543:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1546:	ba 00 00 00 00       	mov    $0x0,%edx
    154b:	f7 75 d4             	divl   -0x2c(%ebp)
    154e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1551:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1555:	75 c5                	jne    151c <printint+0x38>
    1557:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    155b:	74 28                	je     1585 <printint+0xa1>
    155d:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1560:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)
    1565:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1569:	eb 1a                	jmp    1585 <printint+0xa1>
    156b:	8b 45 ec             	mov    -0x14(%ebp),%eax
    156e:	0f b6 44 05 dc       	movzbl -0x24(%ebp,%eax,1),%eax
    1573:	0f be c0             	movsbl %al,%eax
    1576:	89 44 24 04          	mov    %eax,0x4(%esp)
    157a:	8b 45 08             	mov    0x8(%ebp),%eax
    157d:	89 04 24             	mov    %eax,(%esp)
    1580:	e8 37 ff ff ff       	call   14bc <putc>
    1585:	83 6d ec 01          	subl   $0x1,-0x14(%ebp)
    1589:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    158d:	79 dc                	jns    156b <printint+0x87>
    158f:	83 c4 44             	add    $0x44,%esp
    1592:	5b                   	pop    %ebx
    1593:	5d                   	pop    %ebp
    1594:	c3                   	ret    

00001595 <printf>:
    1595:	55                   	push   %ebp
    1596:	89 e5                	mov    %esp,%ebp
    1598:	83 ec 38             	sub    $0x38,%esp
    159b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    15a2:	8d 45 0c             	lea    0xc(%ebp),%eax
    15a5:	83 c0 04             	add    $0x4,%eax
    15a8:	89 45 f4             	mov    %eax,-0xc(%ebp)
    15ab:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    15b2:	e9 7e 01 00 00       	jmp    1735 <printf+0x1a0>
    15b7:	8b 55 0c             	mov    0xc(%ebp),%edx
    15ba:	8b 45 ec             	mov    -0x14(%ebp),%eax
    15bd:	8d 04 02             	lea    (%edx,%eax,1),%eax
    15c0:	0f b6 00             	movzbl (%eax),%eax
    15c3:	0f be c0             	movsbl %al,%eax
    15c6:	25 ff 00 00 00       	and    $0xff,%eax
    15cb:	89 45 e8             	mov    %eax,-0x18(%ebp)
    15ce:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    15d2:	75 2c                	jne    1600 <printf+0x6b>
    15d4:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    15d8:	75 0c                	jne    15e6 <printf+0x51>
    15da:	c7 45 f0 25 00 00 00 	movl   $0x25,-0x10(%ebp)
    15e1:	e9 4b 01 00 00       	jmp    1731 <printf+0x19c>
    15e6:	8b 45 e8             	mov    -0x18(%ebp),%eax
    15e9:	0f be c0             	movsbl %al,%eax
    15ec:	89 44 24 04          	mov    %eax,0x4(%esp)
    15f0:	8b 45 08             	mov    0x8(%ebp),%eax
    15f3:	89 04 24             	mov    %eax,(%esp)
    15f6:	e8 c1 fe ff ff       	call   14bc <putc>
    15fb:	e9 31 01 00 00       	jmp    1731 <printf+0x19c>
    1600:	83 7d f0 25          	cmpl   $0x25,-0x10(%ebp)
    1604:	0f 85 27 01 00 00    	jne    1731 <printf+0x19c>
    160a:	83 7d e8 64          	cmpl   $0x64,-0x18(%ebp)
    160e:	75 2d                	jne    163d <printf+0xa8>
    1610:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1613:	8b 00                	mov    (%eax),%eax
    1615:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    161c:	00 
    161d:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    1624:	00 
    1625:	89 44 24 04          	mov    %eax,0x4(%esp)
    1629:	8b 45 08             	mov    0x8(%ebp),%eax
    162c:	89 04 24             	mov    %eax,(%esp)
    162f:	e8 b0 fe ff ff       	call   14e4 <printint>
    1634:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    1638:	e9 ed 00 00 00       	jmp    172a <printf+0x195>
    163d:	83 7d e8 78          	cmpl   $0x78,-0x18(%ebp)
    1641:	74 06                	je     1649 <printf+0xb4>
    1643:	83 7d e8 70          	cmpl   $0x70,-0x18(%ebp)
    1647:	75 2d                	jne    1676 <printf+0xe1>
    1649:	8b 45 f4             	mov    -0xc(%ebp),%eax
    164c:	8b 00                	mov    (%eax),%eax
    164e:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    1655:	00 
    1656:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    165d:	00 
    165e:	89 44 24 04          	mov    %eax,0x4(%esp)
    1662:	8b 45 08             	mov    0x8(%ebp),%eax
    1665:	89 04 24             	mov    %eax,(%esp)
    1668:	e8 77 fe ff ff       	call   14e4 <printint>
    166d:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    1671:	e9 b4 00 00 00       	jmp    172a <printf+0x195>
    1676:	83 7d e8 73          	cmpl   $0x73,-0x18(%ebp)
    167a:	75 46                	jne    16c2 <printf+0x12d>
    167c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    167f:	8b 00                	mov    (%eax),%eax
    1681:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    1684:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    1688:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    168c:	75 27                	jne    16b5 <printf+0x120>
    168e:	c7 45 e4 fc 1b 00 00 	movl   $0x1bfc,-0x1c(%ebp)
    1695:	eb 1f                	jmp    16b6 <printf+0x121>
    1697:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    169a:	0f b6 00             	movzbl (%eax),%eax
    169d:	0f be c0             	movsbl %al,%eax
    16a0:	89 44 24 04          	mov    %eax,0x4(%esp)
    16a4:	8b 45 08             	mov    0x8(%ebp),%eax
    16a7:	89 04 24             	mov    %eax,(%esp)
    16aa:	e8 0d fe ff ff       	call   14bc <putc>
    16af:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    16b3:	eb 01                	jmp    16b6 <printf+0x121>
    16b5:	90                   	nop
    16b6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    16b9:	0f b6 00             	movzbl (%eax),%eax
    16bc:	84 c0                	test   %al,%al
    16be:	75 d7                	jne    1697 <printf+0x102>
    16c0:	eb 68                	jmp    172a <printf+0x195>
    16c2:	83 7d e8 63          	cmpl   $0x63,-0x18(%ebp)
    16c6:	75 1d                	jne    16e5 <printf+0x150>
    16c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16cb:	8b 00                	mov    (%eax),%eax
    16cd:	0f be c0             	movsbl %al,%eax
    16d0:	89 44 24 04          	mov    %eax,0x4(%esp)
    16d4:	8b 45 08             	mov    0x8(%ebp),%eax
    16d7:	89 04 24             	mov    %eax,(%esp)
    16da:	e8 dd fd ff ff       	call   14bc <putc>
    16df:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    16e3:	eb 45                	jmp    172a <printf+0x195>
    16e5:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    16e9:	75 17                	jne    1702 <printf+0x16d>
    16eb:	8b 45 e8             	mov    -0x18(%ebp),%eax
    16ee:	0f be c0             	movsbl %al,%eax
    16f1:	89 44 24 04          	mov    %eax,0x4(%esp)
    16f5:	8b 45 08             	mov    0x8(%ebp),%eax
    16f8:	89 04 24             	mov    %eax,(%esp)
    16fb:	e8 bc fd ff ff       	call   14bc <putc>
    1700:	eb 28                	jmp    172a <printf+0x195>
    1702:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    1709:	00 
    170a:	8b 45 08             	mov    0x8(%ebp),%eax
    170d:	89 04 24             	mov    %eax,(%esp)
    1710:	e8 a7 fd ff ff       	call   14bc <putc>
    1715:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1718:	0f be c0             	movsbl %al,%eax
    171b:	89 44 24 04          	mov    %eax,0x4(%esp)
    171f:	8b 45 08             	mov    0x8(%ebp),%eax
    1722:	89 04 24             	mov    %eax,(%esp)
    1725:	e8 92 fd ff ff       	call   14bc <putc>
    172a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1731:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1735:	8b 55 0c             	mov    0xc(%ebp),%edx
    1738:	8b 45 ec             	mov    -0x14(%ebp),%eax
    173b:	8d 04 02             	lea    (%edx,%eax,1),%eax
    173e:	0f b6 00             	movzbl (%eax),%eax
    1741:	84 c0                	test   %al,%al
    1743:	0f 85 6e fe ff ff    	jne    15b7 <printf+0x22>
    1749:	c9                   	leave  
    174a:	c3                   	ret    
    174b:	90                   	nop

0000174c <free>:
    174c:	55                   	push   %ebp
    174d:	89 e5                	mov    %esp,%ebp
    174f:	83 ec 10             	sub    $0x10,%esp
    1752:	8b 45 08             	mov    0x8(%ebp),%eax
    1755:	83 e8 08             	sub    $0x8,%eax
    1758:	89 45 f8             	mov    %eax,-0x8(%ebp)
    175b:	a1 50 1c 00 00       	mov    0x1c50,%eax
    1760:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1763:	eb 24                	jmp    1789 <free+0x3d>
    1765:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1768:	8b 00                	mov    (%eax),%eax
    176a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    176d:	77 12                	ja     1781 <free+0x35>
    176f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1772:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1775:	77 24                	ja     179b <free+0x4f>
    1777:	8b 45 fc             	mov    -0x4(%ebp),%eax
    177a:	8b 00                	mov    (%eax),%eax
    177c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    177f:	77 1a                	ja     179b <free+0x4f>
    1781:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1784:	8b 00                	mov    (%eax),%eax
    1786:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1789:	8b 45 f8             	mov    -0x8(%ebp),%eax
    178c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    178f:	76 d4                	jbe    1765 <free+0x19>
    1791:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1794:	8b 00                	mov    (%eax),%eax
    1796:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1799:	76 ca                	jbe    1765 <free+0x19>
    179b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    179e:	8b 40 04             	mov    0x4(%eax),%eax
    17a1:	c1 e0 03             	shl    $0x3,%eax
    17a4:	89 c2                	mov    %eax,%edx
    17a6:	03 55 f8             	add    -0x8(%ebp),%edx
    17a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17ac:	8b 00                	mov    (%eax),%eax
    17ae:	39 c2                	cmp    %eax,%edx
    17b0:	75 24                	jne    17d6 <free+0x8a>
    17b2:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17b5:	8b 50 04             	mov    0x4(%eax),%edx
    17b8:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17bb:	8b 00                	mov    (%eax),%eax
    17bd:	8b 40 04             	mov    0x4(%eax),%eax
    17c0:	01 c2                	add    %eax,%edx
    17c2:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17c5:	89 50 04             	mov    %edx,0x4(%eax)
    17c8:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17cb:	8b 00                	mov    (%eax),%eax
    17cd:	8b 10                	mov    (%eax),%edx
    17cf:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17d2:	89 10                	mov    %edx,(%eax)
    17d4:	eb 0a                	jmp    17e0 <free+0x94>
    17d6:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17d9:	8b 10                	mov    (%eax),%edx
    17db:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17de:	89 10                	mov    %edx,(%eax)
    17e0:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17e3:	8b 40 04             	mov    0x4(%eax),%eax
    17e6:	c1 e0 03             	shl    $0x3,%eax
    17e9:	03 45 fc             	add    -0x4(%ebp),%eax
    17ec:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    17ef:	75 20                	jne    1811 <free+0xc5>
    17f1:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17f4:	8b 50 04             	mov    0x4(%eax),%edx
    17f7:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17fa:	8b 40 04             	mov    0x4(%eax),%eax
    17fd:	01 c2                	add    %eax,%edx
    17ff:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1802:	89 50 04             	mov    %edx,0x4(%eax)
    1805:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1808:	8b 10                	mov    (%eax),%edx
    180a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    180d:	89 10                	mov    %edx,(%eax)
    180f:	eb 08                	jmp    1819 <free+0xcd>
    1811:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1814:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1817:	89 10                	mov    %edx,(%eax)
    1819:	8b 45 fc             	mov    -0x4(%ebp),%eax
    181c:	a3 50 1c 00 00       	mov    %eax,0x1c50
    1821:	c9                   	leave  
    1822:	c3                   	ret    

00001823 <morecore>:
    1823:	55                   	push   %ebp
    1824:	89 e5                	mov    %esp,%ebp
    1826:	83 ec 28             	sub    $0x28,%esp
    1829:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    1830:	77 07                	ja     1839 <morecore+0x16>
    1832:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
    1839:	8b 45 08             	mov    0x8(%ebp),%eax
    183c:	c1 e0 03             	shl    $0x3,%eax
    183f:	89 04 24             	mov    %eax,(%esp)
    1842:	e8 35 fc ff ff       	call   147c <sbrk>
    1847:	89 45 f0             	mov    %eax,-0x10(%ebp)
    184a:	83 7d f0 ff          	cmpl   $0xffffffff,-0x10(%ebp)
    184e:	75 07                	jne    1857 <morecore+0x34>
    1850:	b8 00 00 00 00       	mov    $0x0,%eax
    1855:	eb 22                	jmp    1879 <morecore+0x56>
    1857:	8b 45 f0             	mov    -0x10(%ebp),%eax
    185a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    185d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1860:	8b 55 08             	mov    0x8(%ebp),%edx
    1863:	89 50 04             	mov    %edx,0x4(%eax)
    1866:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1869:	83 c0 08             	add    $0x8,%eax
    186c:	89 04 24             	mov    %eax,(%esp)
    186f:	e8 d8 fe ff ff       	call   174c <free>
    1874:	a1 50 1c 00 00       	mov    0x1c50,%eax
    1879:	c9                   	leave  
    187a:	c3                   	ret    

0000187b <malloc>:
    187b:	55                   	push   %ebp
    187c:	89 e5                	mov    %esp,%ebp
    187e:	83 ec 28             	sub    $0x28,%esp
    1881:	8b 45 08             	mov    0x8(%ebp),%eax
    1884:	83 c0 07             	add    $0x7,%eax
    1887:	c1 e8 03             	shr    $0x3,%eax
    188a:	83 c0 01             	add    $0x1,%eax
    188d:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1890:	a1 50 1c 00 00       	mov    0x1c50,%eax
    1895:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1898:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    189c:	75 23                	jne    18c1 <malloc+0x46>
    189e:	c7 45 f0 48 1c 00 00 	movl   $0x1c48,-0x10(%ebp)
    18a5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    18a8:	a3 50 1c 00 00       	mov    %eax,0x1c50
    18ad:	a1 50 1c 00 00       	mov    0x1c50,%eax
    18b2:	a3 48 1c 00 00       	mov    %eax,0x1c48
    18b7:	c7 05 4c 1c 00 00 00 	movl   $0x0,0x1c4c
    18be:	00 00 00 
    18c1:	8b 45 f0             	mov    -0x10(%ebp),%eax
    18c4:	8b 00                	mov    (%eax),%eax
    18c6:	89 45 ec             	mov    %eax,-0x14(%ebp)
    18c9:	8b 45 ec             	mov    -0x14(%ebp),%eax
    18cc:	8b 40 04             	mov    0x4(%eax),%eax
    18cf:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    18d2:	72 4d                	jb     1921 <malloc+0xa6>
    18d4:	8b 45 ec             	mov    -0x14(%ebp),%eax
    18d7:	8b 40 04             	mov    0x4(%eax),%eax
    18da:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    18dd:	75 0c                	jne    18eb <malloc+0x70>
    18df:	8b 45 ec             	mov    -0x14(%ebp),%eax
    18e2:	8b 10                	mov    (%eax),%edx
    18e4:	8b 45 f0             	mov    -0x10(%ebp),%eax
    18e7:	89 10                	mov    %edx,(%eax)
    18e9:	eb 26                	jmp    1911 <malloc+0x96>
    18eb:	8b 45 ec             	mov    -0x14(%ebp),%eax
    18ee:	8b 40 04             	mov    0x4(%eax),%eax
    18f1:	89 c2                	mov    %eax,%edx
    18f3:	2b 55 f4             	sub    -0xc(%ebp),%edx
    18f6:	8b 45 ec             	mov    -0x14(%ebp),%eax
    18f9:	89 50 04             	mov    %edx,0x4(%eax)
    18fc:	8b 45 ec             	mov    -0x14(%ebp),%eax
    18ff:	8b 40 04             	mov    0x4(%eax),%eax
    1902:	c1 e0 03             	shl    $0x3,%eax
    1905:	01 45 ec             	add    %eax,-0x14(%ebp)
    1908:	8b 45 ec             	mov    -0x14(%ebp),%eax
    190b:	8b 55 f4             	mov    -0xc(%ebp),%edx
    190e:	89 50 04             	mov    %edx,0x4(%eax)
    1911:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1914:	a3 50 1c 00 00       	mov    %eax,0x1c50
    1919:	8b 45 ec             	mov    -0x14(%ebp),%eax
    191c:	83 c0 08             	add    $0x8,%eax
    191f:	eb 38                	jmp    1959 <malloc+0xde>
    1921:	a1 50 1c 00 00       	mov    0x1c50,%eax
    1926:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    1929:	75 1b                	jne    1946 <malloc+0xcb>
    192b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    192e:	89 04 24             	mov    %eax,(%esp)
    1931:	e8 ed fe ff ff       	call   1823 <morecore>
    1936:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1939:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    193d:	75 07                	jne    1946 <malloc+0xcb>
    193f:	b8 00 00 00 00       	mov    $0x0,%eax
    1944:	eb 13                	jmp    1959 <malloc+0xde>
    1946:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1949:	89 45 f0             	mov    %eax,-0x10(%ebp)
    194c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    194f:	8b 00                	mov    (%eax),%eax
    1951:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1954:	e9 70 ff ff ff       	jmp    18c9 <malloc+0x4e>
    1959:	c9                   	leave  
    195a:	c3                   	ret    
    195b:	90                   	nop

0000195c <xchg>:
    195c:	55                   	push   %ebp
    195d:	89 e5                	mov    %esp,%ebp
    195f:	83 ec 10             	sub    $0x10,%esp
    1962:	8b 55 08             	mov    0x8(%ebp),%edx
    1965:	8b 45 0c             	mov    0xc(%ebp),%eax
    1968:	8b 4d 08             	mov    0x8(%ebp),%ecx
    196b:	f0 87 02             	lock xchg %eax,(%edx)
    196e:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1971:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1974:	c9                   	leave  
    1975:	c3                   	ret    

00001976 <lock_init>:
    1976:	55                   	push   %ebp
    1977:	89 e5                	mov    %esp,%ebp
    1979:	8b 45 08             	mov    0x8(%ebp),%eax
    197c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    1982:	5d                   	pop    %ebp
    1983:	c3                   	ret    

00001984 <lock_acquire>:
    1984:	55                   	push   %ebp
    1985:	89 e5                	mov    %esp,%ebp
    1987:	83 ec 08             	sub    $0x8,%esp
    198a:	8b 45 08             	mov    0x8(%ebp),%eax
    198d:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    1994:	00 
    1995:	89 04 24             	mov    %eax,(%esp)
    1998:	e8 bf ff ff ff       	call   195c <xchg>
    199d:	85 c0                	test   %eax,%eax
    199f:	75 e9                	jne    198a <lock_acquire+0x6>
    19a1:	c9                   	leave  
    19a2:	c3                   	ret    

000019a3 <lock_release>:
    19a3:	55                   	push   %ebp
    19a4:	89 e5                	mov    %esp,%ebp
    19a6:	83 ec 08             	sub    $0x8,%esp
    19a9:	8b 45 08             	mov    0x8(%ebp),%eax
    19ac:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    19b3:	00 
    19b4:	89 04 24             	mov    %eax,(%esp)
    19b7:	e8 a0 ff ff ff       	call   195c <xchg>
    19bc:	c9                   	leave  
    19bd:	c3                   	ret    

000019be <thread_create>:
    19be:	55                   	push   %ebp
    19bf:	89 e5                	mov    %esp,%ebp
    19c1:	83 ec 28             	sub    $0x28,%esp
    19c4:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    19cb:	e8 ab fe ff ff       	call   187b <malloc>
    19d0:	89 45 f0             	mov    %eax,-0x10(%ebp)
    19d3:	8b 45 f0             	mov    -0x10(%ebp),%eax
    19d6:	89 45 f4             	mov    %eax,-0xc(%ebp)
    19d9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    19dc:	25 ff 0f 00 00       	and    $0xfff,%eax
    19e1:	85 c0                	test   %eax,%eax
    19e3:	74 15                	je     19fa <thread_create+0x3c>
    19e5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    19e8:	89 c2                	mov    %eax,%edx
    19ea:	81 e2 ff 0f 00 00    	and    $0xfff,%edx
    19f0:	b8 00 10 00 00       	mov    $0x1000,%eax
    19f5:	29 d0                	sub    %edx,%eax
    19f7:	01 45 f0             	add    %eax,-0x10(%ebp)
    19fa:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    19fe:	75 1b                	jne    1a1b <thread_create+0x5d>
    1a00:	c7 44 24 04 03 1c 00 	movl   $0x1c03,0x4(%esp)
    1a07:	00 
    1a08:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1a0f:	e8 81 fb ff ff       	call   1595 <printf>
    1a14:	b8 00 00 00 00       	mov    $0x0,%eax
    1a19:	eb 6f                	jmp    1a8a <thread_create+0xcc>
    1a1b:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1a1e:	8b 55 08             	mov    0x8(%ebp),%edx
    1a21:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a24:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    1a28:	89 54 24 08          	mov    %edx,0x8(%esp)
    1a2c:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    1a33:	00 
    1a34:	89 04 24             	mov    %eax,(%esp)
    1a37:	e8 58 fa ff ff       	call   1494 <clone>
    1a3c:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1a3f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1a43:	79 1b                	jns    1a60 <thread_create+0xa2>
    1a45:	c7 44 24 04 11 1c 00 	movl   $0x1c11,0x4(%esp)
    1a4c:	00 
    1a4d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1a54:	e8 3c fb ff ff       	call   1595 <printf>
    1a59:	b8 00 00 00 00       	mov    $0x0,%eax
    1a5e:	eb 2a                	jmp    1a8a <thread_create+0xcc>
    1a60:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1a64:	7e 05                	jle    1a6b <thread_create+0xad>
    1a66:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a69:	eb 1f                	jmp    1a8a <thread_create+0xcc>
    1a6b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1a6f:	75 14                	jne    1a85 <thread_create+0xc7>
    1a71:	c7 44 24 04 1e 1c 00 	movl   $0x1c1e,0x4(%esp)
    1a78:	00 
    1a79:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1a80:	e8 10 fb ff ff       	call   1595 <printf>
    1a85:	b8 00 00 00 00       	mov    $0x0,%eax
    1a8a:	c9                   	leave  
    1a8b:	c3                   	ret    

00001a8c <random>:
    1a8c:	55                   	push   %ebp
    1a8d:	89 e5                	mov    %esp,%ebp
    1a8f:	a1 44 1c 00 00       	mov    0x1c44,%eax
    1a94:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    1a9a:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
    1a9f:	a3 44 1c 00 00       	mov    %eax,0x1c44
    1aa4:	a1 44 1c 00 00       	mov    0x1c44,%eax
    1aa9:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1aac:	ba 00 00 00 00       	mov    $0x0,%edx
    1ab1:	f7 f1                	div    %ecx
    1ab3:	89 d0                	mov    %edx,%eax
    1ab5:	5d                   	pop    %ebp
    1ab6:	c3                   	ret    
    1ab7:	90                   	nop

00001ab8 <init_q>:
    1ab8:	55                   	push   %ebp
    1ab9:	89 e5                	mov    %esp,%ebp
    1abb:	8b 45 08             	mov    0x8(%ebp),%eax
    1abe:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    1ac4:	8b 45 08             	mov    0x8(%ebp),%eax
    1ac7:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    1ace:	8b 45 08             	mov    0x8(%ebp),%eax
    1ad1:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
    1ad8:	5d                   	pop    %ebp
    1ad9:	c3                   	ret    

00001ada <add_q>:
    1ada:	55                   	push   %ebp
    1adb:	89 e5                	mov    %esp,%ebp
    1add:	83 ec 28             	sub    $0x28,%esp
    1ae0:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    1ae7:	e8 8f fd ff ff       	call   187b <malloc>
    1aec:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1aef:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1af2:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    1af9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1afc:	8b 55 0c             	mov    0xc(%ebp),%edx
    1aff:	89 10                	mov    %edx,(%eax)
    1b01:	8b 45 08             	mov    0x8(%ebp),%eax
    1b04:	8b 40 04             	mov    0x4(%eax),%eax
    1b07:	85 c0                	test   %eax,%eax
    1b09:	75 0b                	jne    1b16 <add_q+0x3c>
    1b0b:	8b 45 08             	mov    0x8(%ebp),%eax
    1b0e:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1b11:	89 50 04             	mov    %edx,0x4(%eax)
    1b14:	eb 0c                	jmp    1b22 <add_q+0x48>
    1b16:	8b 45 08             	mov    0x8(%ebp),%eax
    1b19:	8b 40 08             	mov    0x8(%eax),%eax
    1b1c:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1b1f:	89 50 04             	mov    %edx,0x4(%eax)
    1b22:	8b 45 08             	mov    0x8(%ebp),%eax
    1b25:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1b28:	89 50 08             	mov    %edx,0x8(%eax)
    1b2b:	8b 45 08             	mov    0x8(%ebp),%eax
    1b2e:	8b 00                	mov    (%eax),%eax
    1b30:	8d 50 01             	lea    0x1(%eax),%edx
    1b33:	8b 45 08             	mov    0x8(%ebp),%eax
    1b36:	89 10                	mov    %edx,(%eax)
    1b38:	c9                   	leave  
    1b39:	c3                   	ret    

00001b3a <empty_q>:
    1b3a:	55                   	push   %ebp
    1b3b:	89 e5                	mov    %esp,%ebp
    1b3d:	8b 45 08             	mov    0x8(%ebp),%eax
    1b40:	8b 00                	mov    (%eax),%eax
    1b42:	85 c0                	test   %eax,%eax
    1b44:	75 07                	jne    1b4d <empty_q+0x13>
    1b46:	b8 01 00 00 00       	mov    $0x1,%eax
    1b4b:	eb 05                	jmp    1b52 <empty_q+0x18>
    1b4d:	b8 00 00 00 00       	mov    $0x0,%eax
    1b52:	5d                   	pop    %ebp
    1b53:	c3                   	ret    

00001b54 <pop_q>:
    1b54:	55                   	push   %ebp
    1b55:	89 e5                	mov    %esp,%ebp
    1b57:	83 ec 28             	sub    $0x28,%esp
    1b5a:	8b 45 08             	mov    0x8(%ebp),%eax
    1b5d:	89 04 24             	mov    %eax,(%esp)
    1b60:	e8 d5 ff ff ff       	call   1b3a <empty_q>
    1b65:	85 c0                	test   %eax,%eax
    1b67:	75 5d                	jne    1bc6 <pop_q+0x72>
    1b69:	8b 45 08             	mov    0x8(%ebp),%eax
    1b6c:	8b 40 04             	mov    0x4(%eax),%eax
    1b6f:	8b 00                	mov    (%eax),%eax
    1b71:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1b74:	8b 45 08             	mov    0x8(%ebp),%eax
    1b77:	8b 40 04             	mov    0x4(%eax),%eax
    1b7a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1b7d:	8b 45 08             	mov    0x8(%ebp),%eax
    1b80:	8b 40 04             	mov    0x4(%eax),%eax
    1b83:	8b 50 04             	mov    0x4(%eax),%edx
    1b86:	8b 45 08             	mov    0x8(%ebp),%eax
    1b89:	89 50 04             	mov    %edx,0x4(%eax)
    1b8c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b8f:	89 04 24             	mov    %eax,(%esp)
    1b92:	e8 b5 fb ff ff       	call   174c <free>
    1b97:	8b 45 08             	mov    0x8(%ebp),%eax
    1b9a:	8b 00                	mov    (%eax),%eax
    1b9c:	8d 50 ff             	lea    -0x1(%eax),%edx
    1b9f:	8b 45 08             	mov    0x8(%ebp),%eax
    1ba2:	89 10                	mov    %edx,(%eax)
    1ba4:	8b 45 08             	mov    0x8(%ebp),%eax
    1ba7:	8b 00                	mov    (%eax),%eax
    1ba9:	85 c0                	test   %eax,%eax
    1bab:	75 14                	jne    1bc1 <pop_q+0x6d>
    1bad:	8b 45 08             	mov    0x8(%ebp),%eax
    1bb0:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    1bb7:	8b 45 08             	mov    0x8(%ebp),%eax
    1bba:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
    1bc1:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1bc4:	eb 05                	jmp    1bcb <pop_q+0x77>
    1bc6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1bcb:	c9                   	leave  
    1bcc:	c3                   	ret    
