FactoryGirl.define do
  factory :computer do
    model 'iMac'
    monitor_size '21.5"'
    ram_size 8096
    processor '1.4GHz'
    ssd true
    storage_size '500GB'
    graphics_card 'Intel HD Graphics 5000'

    trait :monitor_size_27 do
      monitor_size '27"'
    end

    trait :ram_size_16gb do
      ram_size 16192
    end

    trait :ram_size_32gb do
      ram_size 32384
    end

    trait :processor_quad_34 do
      processor '3.4GHz Intel Quad-core'
    end

    trait :processor_quad_32 do
      processor '3.2GHz Intel Quad-core'
    end

    trait :without_ssd do
      ssd false
    end

    trait :storage_size_1000_5400 do
      ssd false
      storage_size 1000
    end

    trait :storage_size_1000_7200 do
      ssd true
      storage_size 1000
    end

    trait :graphics_card_nvidia do
      graphics_card 'NVIDIA GeForce GTX 775M'
    end
  end
end
