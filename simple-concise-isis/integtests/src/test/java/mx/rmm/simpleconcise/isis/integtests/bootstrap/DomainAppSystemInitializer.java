/*
 *  Licensed to the Apache Software Foundation (ASF) under one
 *  or more contributor license agreements.  See the NOTICE file
 *  distributed with this work for additional information
 *  regarding copyright ownership.  The ASF licenses this file
 *  to you under the Apache License, Version 2.0 (the
 *  "License"); you may not use this file except in compliance
 *  with the License.  You may obtain a copy of the License at
 *
 *        http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing,
 *  software distributed under the License is distributed on an
 *  "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 *  KIND, either express or implied.  See the License for the
 *  specific language governing permissions and limitations
 *  under the License.
 */
package mx.rmm.simpleconcise.isis.integtests.bootstrap;

import java.util.Map;

import com.google.common.collect.Maps;

import mx.rmm.simpleconcise.isis.app.DomainAppAppManifest;

import org.apache.isis.core.integtestsupport.IsisSystemForTest;

public class DomainAppSystemInitializer {

    public static void initIsft() {
        IsisSystemForTest isft = IsisSystemForTest.getElseNull();
        if(isft == null) {
            isft = new IsisSystemForTest.Builder()
                    .withLoggingAt(org.apache.log4j.Level.INFO)
                    .with(new DomainAppAppManifest() {
                        @Override
                        public Map<String, String> getConfigurationProperties() {
                            final Map<String, String> map = Maps.newHashMap();
                            Util.withJavaxJdoRunInMemoryProperties(map);
                            Util.withDataNucleusProperties(map);
                            Util.withIsisIntegTestProperties(map);
                            return map;
                        }
                    })
                    .build();
            isft.setUpSystem();
            IsisSystemForTest.set(isft);
        }
    }

}
