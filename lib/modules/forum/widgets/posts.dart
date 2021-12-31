import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icovid_app/modules/forum/services/services.dart';

Widget thumbify(ForumPost forumPost) {
		return Container(
              height: 180,
              margin: const EdgeInsets.all(15.0),
              decoration: BoxDecoration( 
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [BoxShadow(
                  color: Colors.black26.withOpacity(0.05),
                  offset: const Offset(0.0,6.0),
                  blurRadius: 10.0,
                  spreadRadius: 0.10
                )]
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column( 
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      height: 70,  
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    SizedBox( 
                                      child: Text(
                                        forumPost.topic,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: .4
                                        ),
                                      ),
                                    ), 
                                    const SizedBox(height: 2.0),
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          forumPost.author,
                                          style: TextStyle(
                                            color: Colors.grey.withOpacity(0.6)
                                          ),
                                        ),
                                        const SizedBox(width: 15),
                                        Text(
                                          forumPost.date_created,
                                          style: TextStyle(
                                            color: Colors.grey.withOpacity(0.6)
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 50, 
                      child: Center(
                        child: Text(
                          forumPost.description,
                          style: TextStyle(
                            color: Colors.grey.withOpacity(0.8),
                            fontSize: 16,
                            letterSpacing: .3
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
              ),
            );
	}