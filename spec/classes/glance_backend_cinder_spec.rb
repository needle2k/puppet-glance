#
# Copyright (C) 2013 eNovance SAS <licensing@enovance.com>
#
# Author: Emilien Macchi <emilien.macchi@enovance.com>
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may
# not use this file except in compliance with the License. You may obtain
# a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations
# under the License.
#
# Unit tests for glance::backend::cinder class
#

require 'spec_helper'

describe 'glance::backend::cinder' do

  let :pre_condition do
    'class { "glance::api::authtoken": password => "pass" }'
  end

  shared_examples_for 'glance with cinder backend' do

    context 'when default parameters' do

      it 'configures glance-api.conf' do
        is_expected.to contain_glance_api_config('glance_store/default_store').with_value('cinder')
        is_expected.to contain_glance_api_config('glance_store/default_store').with_value('cinder')
        is_expected.to contain_glance_api_config('glance_store/cinder_api_insecure').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_glance_api_config('glance_store/cinder_catalog_info').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_glance_api_config('glance_store/cinder_http_retries').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_glance_api_config('glance_store/cinder_ca_certificates_file').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_glance_api_config('glance_store/cinder_endpoint_template').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_glance_api_config('glance_store/cinder_store_auth_address').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_glance_api_config('glance_store/cinder_store_project_name').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_glance_api_config('glance_store/cinder_store_user_name').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_glance_api_config('glance_store/cinder_store_password').with_value('<SERVICE DEFAULT>')
      end
      it 'configures glance-cache.conf' do
        is_expected.to contain_glance_cache_config('glance_store/cinder_api_insecure').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_glance_cache_config('glance_store/cinder_catalog_info').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_glance_cache_config('glance_store/cinder_http_retries').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_glance_cache_config('glance_store/cinder_ca_certificates_file').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_glance_cache_config('glance_store/cinder_endpoint_template').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_glance_cache_config('glance_store/cinder_store_auth_address').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_glance_cache_config('glance_store/cinder_store_project_name').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_glance_cache_config('glance_store/cinder_store_user_name').with_value('<SERVICE DEFAULT>')
        is_expected.to contain_glance_cache_config('glance_store/cinder_store_password').with_value('<SERVICE DEFAULT>')
      end
    end

    context 'when overriding parameters' do
      let :params do
        {
          :cinder_api_insecure         => true,
          :cinder_ca_certificates_file => '/etc/ssh/ca.crt',
          :cinder_catalog_info         => 'volume:cinder:internalURL',
          :cinder_endpoint_template    => 'http://srv-foo:8776/v1/%(project_id)s',
          :cinder_http_retries         => '10',
          :cinder_store_auth_address   => '127.0.0.2:8080/v3/',
          :cinder_store_project_name   => 'services',
          :cinder_store_user_name      => 'glance',
          :cinder_store_password       => 'glance',
        }
      end
      it 'configures glance-api.conf' do
        is_expected.to contain_glance_api_config('glance_store/cinder_api_insecure').with_value(true)
        is_expected.to contain_glance_api_config('glance_store/cinder_ca_certificates_file').with_value('/etc/ssh/ca.crt')
        is_expected.to contain_glance_api_config('glance_store/cinder_catalog_info').with_value('volume:cinder:internalURL')
        is_expected.to contain_glance_api_config('glance_store/cinder_endpoint_template').with_value('http://srv-foo:8776/v1/%(project_id)s')
        is_expected.to contain_glance_api_config('glance_store/cinder_http_retries').with_value('10')
        is_expected.to contain_glance_api_config('glance_store/cinder_store_auth_address').with_value('127.0.0.2:8080/v3/')
        is_expected.to contain_glance_api_config('glance_store/cinder_store_project_name').with_value('services')
        is_expected.to contain_glance_api_config('glance_store/cinder_store_user_name').with_value('glance')
        is_expected.to contain_glance_api_config('glance_store/cinder_store_password').with_value('glance')
      end
      it 'configures glance-cache.conf' do
        is_expected.to contain_glance_cache_config('glance_store/cinder_api_insecure').with_value(true)
        is_expected.to contain_glance_cache_config('glance_store/cinder_ca_certificates_file').with_value('/etc/ssh/ca.crt')
        is_expected.to contain_glance_cache_config('glance_store/cinder_catalog_info').with_value('volume:cinder:internalURL')
        is_expected.to contain_glance_cache_config('glance_store/cinder_endpoint_template').with_value('http://srv-foo:8776/v1/%(project_id)s')
        is_expected.to contain_glance_cache_config('glance_store/cinder_http_retries').with_value('10')
        is_expected.to contain_glance_cache_config('glance_store/cinder_store_auth_address').with_value('127.0.0.2:8080/v3/')
        is_expected.to contain_glance_cache_config('glance_store/cinder_store_project_name').with_value('services')
        is_expected.to contain_glance_cache_config('glance_store/cinder_store_user_name').with_value('glance')
        is_expected.to contain_glance_cache_config('glance_store/cinder_store_password').with_value('glance')
      end
    end
  end


  on_supported_os({
    :supported_os   => OSDefaults.get_supported_os
  }).each do |os,facts|
    context "on #{os}" do
      let (:facts) do
        facts.merge!(OSDefaults.get_facts())
      end

      it_configures 'glance with cinder backend'
    end
  end
end
