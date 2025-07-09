
import 'dart:convert';

import 'package:http/http.dart' as http;
import "package:googleapis_auth/auth_io.dart";

// isolateSend(realState) async {
//   sendNotification(
//     id: realState.id,
//     realState: realState,
//     image: realState.images.isEmpty ? null : realState.images[0],
//   );
// }

// Future<void> sendNotification(
//     {required String id,
//     required RealState realState,
//     required String? image}) async {
//   AccessCredentials credentials = await obtainCredentials();
//   var apiUrl = Uri.parse(
//       "https://fcm.googleapis.com/v1/projects/moger-pro/messages:send");
//   var q = await DB
//       .firestore(Categories.alertes)
//       .doc(realState.categorie)
//       .collection(Categories.alertes)
//       .get();
//   // for (var element in q.docs) {
//   //   var alerte = Alerte.fromMap(element.data());
//   //   if (alerte.region == realState.region &&
//   //       (alerte.villes.contains(realState.ville) ||
//   //           alerte.villes.isEmpty ||
//   //           alerte.villes.contains("Autres"))) {
//   //     if (alerte.vente == null) {
//   //       await sendToToken(
//   //           body: realState.description,
//   //           categorie: realState.categorie,
//   //           id: id,
//   //           apiUrl: apiUrl,
//   //           credentials: credentials,
//   //           uid: alerte.uid);
//   //     } else {
//   //       if (alerte.vente == realState.vente) {
//   //         if (alerte.budgetMax == null) {
//   //           if (alerte.budgetMin == null) {
//   //             await sendToToken(
//   //                 body: realState.description,
//   //                 categorie: realState.categorie,
//   //                 id: id,
//   //                 apiUrl: apiUrl,
//   //                 credentials: credentials,
//   //                 uid: alerte.uid);
//   //           } else {
//   //             if (realState.prix >= alerte.budgetMin!) {
//   //               await sendToToken(
//   //                   body: realState.description,
//   //                   categorie: realState.categorie,
//   //                   id: id,
//   //                   apiUrl: apiUrl,
//   //                   credentials: credentials,
//   //                   uid: alerte.uid);
//   //             }
//   //           }
//   //         } else {
//   //           if (alerte.budgetMin == null) {
//   //             if (realState.prix <= alerte.budgetMax!) {
//   //               await sendToToken(
//   //                   body: realState.description,
//   //                   categorie: realState.categorie,
//   //                   id: id,
//   //                   apiUrl: apiUrl,
//   //                   credentials: credentials,
//   //                   uid: alerte.uid);
//   //             }
//   //           } else {
//   //             if (realState.prix <= alerte.budgetMax! &&
//   //                 realState.prix >= alerte.budgetMin!) {
//   //               await sendToToken(
//   //                   body: realState.description,
//   //                   categorie: realState.categorie,
//   //                   id: id,
//   //                   apiUrl: apiUrl,
//   //                   credentials: credentials,
//   //                   uid: alerte.uid);
//   //             }
//   //           }
//   //         }
//   //       }
//   //     }
//   //   }
//   // }
//   // Map<String, dynamic> map = {
//   //   "message": {
//   //     "topic": topic,
//   //     "notification": {
//   //       "title": title,
//   //       "body": body,
//   //     },
//   //     "data": {"collection": categorie, 'id': id}
//   //   },
//   // };
// }

// Future<dynamic> getToken({required String uid}) async {
//   var sq = await DB.firestore(Categories.utilistateurs).doc(uid).get();
//   var token = sq.data()!['token'];
//   return token;
// }

// Future<void> sendToToken(
//     {required String body,
//     required String categorie,
//     required String id,
//     required Uri apiUrl,
//     required AccessCredentials credentials,
//     required String uid}) async {
//   var token = await getToken(uid: uid);
//   Map<String, dynamic> map = {
//     "message": {
//       "token": token,
//       "notification": {
//         "body": body,
//         "title": categorie == Categories.terrains
//             ? 'Nouveau terrain publié'
//             : categorie == Categories.maisons
//                 ? 'Nouveelle maison publiée'
//                 : categorie == Categories.chambres
//                     ? 'Nouvelle chambre/appart publiée'
//                     : categorie == Categories.chambres
//                         ? 'Nouveau local commercial publiée'
//                         : "Nouveau bien publié",
//       },
//       "data": {"collection": categorie, 'id': id}
//     }
//   };
//   var response = await http.post(apiUrl,
//       headers: {
//         "Authorization": "Bearer ${credentials.accessToken.data}",
//         "Content-Type": "application/json"
//       },
//       body: json.encode(map));
// }

// Future<AccessCredentials> obtainCredentials() async {
//   var accountCredentials = ServiceAccountCredentials.fromJson({
//     "private_key_id": "889a4509d4af0adfbd778f2bd0d7c701175e5d70",
//     "private_key":
//         "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDFjYX/ZZS637L+\nZbTt+kVqWrvxtdegfFzCrHNmHGFGPl41eSd44d6hw53IhNCdt0DUDdNhzVOpbrH5\n+fvgJsZPmXuxhGl4k5crIn+3eq/czS7Q/8HwG+vPVQKdMsRfFpuAmQieO3KstbSV\nPFWetn+QOF7MSdQ2FI6EEIByYp5C/Qph6xdfgsFjcCFfpZr3WLjKQQHFHSZ8iGJH\n2cce8tOC7JslXzGKoS4XiHa+w5tqvyb+LsJRlJIabHxiui6uWtoNb/+IJHRNOqJS\nlNgBtznbDL3DWYFAt3XK/FIkKtgldo5Ffey58msybaQM7y18W0ObdpKdFB0VgiI+\npt/b+zk7AgMBAAECggEAXTSy8ncyT2LouAczcI5CfvXVM6rYU8MpHr4vag9cw7/8\nQd1qBqoGmKrLAEbNiIPj5ciqITw3SzrLZMYRlMWmjfq7tdrjyjxUN8k8mcwcOiBi\nhMAOd+MshDM3GwTPSo/HiUpqmwEwTxUh4MFJIis3j0tRSrBQm71iKiQA/jbSNYcK\nKYAZJU2nlnr7CkJLyOJDGyvbMKFO1u2DLQpw1w2x9RrGjeJeaV6B0dUQzxz+uP4t\nXSiko+nARbMcCOi6NK/FaOEM572r2n1ATsUSnA+eCc8KLj8sK5aOSFBQbAlFc6rm\n9fTK58OG6pygmjDWiVSltEZVwoI7TbqCMWY+bDMG0QKBgQDpl2fuosh948tKm83B\nb9/kFB1odNhcxgfETHZOX6iGVFv/Nor0gU5zSWsNgms34cB+AJsCdhLHP2esalnE\nlDJEQYAlD4B9rR8SieLu++blPHCRA0bb4O5D+rAP/oqMCO4KDwgG+ZLlPmiqnHWD\n7dA5+1cPTo9AwU88IbcvwlKCCwKBgQDYgRKkbCWX3h9eQxKNwF3viXXMAO++RenZ\nqsBanFKEwzFhG3FTzXGeQmtUnEqhRiHKVSa+8j4rckUmG52CtX6xc87rjqvKaaMm\nNMlLzlhCXDWehrHDKTHKypN6pWlPej1Ts4zi1jCMloEhAfOF/u7cXPtYMp0an2a3\nK5D6dQJTkQKBgGd+4tiznRtSC2dyIrbbB5r5YpI+ewKX5ycNLbnJ3lQuGli4ZNay\nV/zygZEJwNGQn4X0ZLmxcN6A9EFLGZzkgGUHlGxXMvn783F2UGrMh1/36HQHvKR9\nQ3QxJULg56fl6Pnh8Q+OEoypmxxEmDis7H5UIx2wE/5/58hfs9dgRMhDAoGAYn0M\n8vkzfMuR73qJlSxeTxp0GNKQPTlmsRspF88nBrgY3Xjza9D4j6rdUocquATEWFu2\nHYTrXS5FYJmNZKmVsbnh9mxXn+PAUSAQNkjvA3kY9z2E3if+O6c9wbw/lOUhwtLa\nE1KmkT3iDhbqJhmbpWky+aNErpi2zDqoYBcccNECgYEAwWlUj6uSrv3V6DlaXF6O\no32+PIltDFz09LMfEDe8gtEYrKAKdfDlijjv6YBOUwRRHya7hR9W0RDolW8T3dlI\n13d+J8vZFBZumK3OGVPscGJ/C9SEDhjD+j3L2vXmFq9uoVhkjWwP06KPQPscnI6q\nFOUZDAQEFy8OJiJqBGsVKnk=\n-----END PRIVATE KEY-----\n",
//     "client_email": "moger-pro@appspot.gserviceaccount.com",
//     "client_id": "105763904098429968569",
//     "type": "service_account"
//   });
//   var scopes = <String>['https://www.googleapis.com/auth/firebase.messaging'];

//   var client = http.Client();
//   AccessCredentials credentials =
//       await obtainAccessCredentialsViaServiceAccount(
//           accountCredentials, scopes, client);

//   client.close();
//   return credentials;
// }


Future<void> sendToToken(
    {required String body,
    required id,
    required String title,
    required String token}) async {
  final credentials = await obtainCredentials();
  Map<String, dynamic> map = {
    "message": {
      "token": token,
      "notification": {
        "body": body,
        "title": title,
      },
      "data": {"to": "RealState", 'id': id}
    }
  };
  var apiUrl = Uri.parse(
      "https://fcm.googleapis.com/v1/projects/moger-pro/messages:send");
  var response = await http.post(apiUrl,
      headers: {
        "Authorization": "Bearer ${credentials.accessToken.data}",
        "Content-Type": "application/json"
      },
      body: json.encode(map));
}

Future<AccessCredentials> obtainCredentials() async {
   var accountCredentials = ServiceAccountCredentials.fromJson({
    "private_key_id": "012efbd2a0046cc744428160df9122ff7d26a6d8",
    "private_key":
        "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCs3OiibR4i4oVI\ncBp0aItKEk3l1FpSE9m98s1NyA33BM06m7qrUxQBdEQfUa68RgzOqYgGrD3IqTa2\nB4jnAb355J8kjX/lR4uSdGyvvI+3X14RCCRgPU7hW9tvtp5EJzeQ7DL190bN4/2M\nafFbYqKoh9Vp7epPat9Nzx0tLmLrjP9jJfyHm7anaj8Y11cW9uK9KTaj1U0dHBOW\n/lmFJigQJACLCmQhlJyTox7DcsvyP4UwzOL6ALxUxhKGJiZ0guqmHRn+1ndO5W2u\ndceDz7nySSZJYVwsrx14q0aUxcqL4BXwqsesKprJE8maK6+6HJk8sFTTKzylIxhf\nWNDpJNABAgMBAAECggEAAmu9VQ1/yBupo88gmrfeWAMnvL/PpEG/iVbHt+a05dxH\nCsKkr4qsP303KURfxOaa/i+u/k9uFdPjVpMmUFxkkoXocebKp02MQ4i+fytODLKQ\n5t6JImEnbDXo7cCGKMSPFVguekX8U4y1Z8CR0w6fgipVU3yDzRkNP6nmceQZ+ewf\noEV+Ecc5kufRNIwSrLA/Wbvh321d7hTpeHyvhZTkAW8q6UwWovpwjmjb+exFEapW\nwknpZvZXOKUFMBm2YeRK+A4aAKgETeFdTFnlafe8CI+mEiHQlm30Fos5+OQyVM/x\nXjludOIVHI5HjzO0OVRTkWl8gn+Tlb3ouu04/1sWsQKBgQDYQrB+uLBr5sSza0/W\n8Vtp5oIcfccBAjJqxyhpO1n4j5pM7dHrGaKMoBxh6Glj3enzct2vl1hgZ33I8ocf\njhDGsAWKYCCo//pZD2FiFa/W15lPud6dnbGlkfmi/xv7SK37FZF5UoJnbToIqJzq\n0raRQENGtrsQCZNSoE0k9pky0QKBgQDMoLaqIk4W/j/hupiTO4rCtM2ZSVwsosr2\nkppnPpzdvTDAH4xF5kvmrXzVN7Xahq8XFZdJUOnAHfT89fy3IjnoCPgu9ADUfaA6\nDyKv1hZDkHtCTclJJon9KGox8UcT/1LCKeYFTm/XjeDMnHtsCjKdocudYLK+gDGg\nPe8wtfo2MQKBgQCbU3Lu4XodVddLwrTKffoZWu1yx0gKymgp1zeINY/Ofl3mCR4v\nzO66MDmSfNpNV1M0fvkIqBxayZpHnSI+IMyd2ElydM6gc5J9KxXX3Bm6ponAAJEL\nBftVHz58utx/JFmJsJkW2ZM98+6tz2U9J/Dm7JAllxNOVoJQ4z/lX5TzMQKBgQCJ\nY3aBcJsBsR9vDXuXjyixZfeM7cZnab3gI7pri4yDDJ2IwSXLYL6hWOYxuj/tQvSY\nCTUUUrE+/l4Y4YgV5XL/qdYIoGdWRCqqELN3X8R/BKjdcaCt7qRDRzlV4uuYL5t/\nJeZ8tZc+INJITuBHP+mQEKvHNL+OTEAFmM/Z4rTmYQKBgHI4Iy62j4o64ItLB94E\nmnrI0eJlde5EJBKOECwsSwAf0T+WlcCnQYbKQ/rOezZBywJDhyqwqXchpsp0JdHq\npTnTZOzETmK2g0drjZXI9aWROpQyrFzCo87Ss/iQ/cK91s0Sr8nuXThHEBfL9EBN\no6jujFUek6l4nFU+NT+s8W42\n-----END PRIVATE KEY-----\n",
    "client_email": "moger-pro@appspot.gserviceaccount.com",
    "client_id": "101202291308356608981",
    "type": "service_account"
  });
  var scopes = <String>['https://www.googleapis.com/auth/firebase.messaging'];

  var client = http.Client();
  AccessCredentials credentials =
      await obtainAccessCredentialsViaServiceAccount(
          accountCredentials, scopes, client);

  client.close();
  return credentials;
}
