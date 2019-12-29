function type_to_random(return_type)
    if return_type == "Bool"
        tmp = 75
    elseif return_type == "Int8"
        tmp = 100
    elseif return_type == "UInt8"
        tmp = 125
    elseif return_type == "Int16"
        tmp = 150
    elseif return_type == "UInt16"
        tmp = 175
    elseif return_type == "Int32"
        tmp = 200
    elseif return_type == "UInt32"
        tmp = 225
    elseif return_type == "Int64"
        tmp = 250
    elseif return_type == "UInt64"
        tmp = 275
    elseif return_type == "Int128"
        tmp = 300
    elseif return_type == "UInt128"
        tmp = 325
    elseif return_type == "BigInt"
        tmp = 350
    elseif return_type == "Rational"
        tmp = 375
    elseif return_type == "Irrational"
        tmp = 400
    elseif return_type == "Float16"
        tmp = 425
    elseif return_type == "Float32"
        tmp = 450
    elseif return_type == "Float64"
        tmp = 475
    elseif return_type == "BigFloat"
        tmp = 500
    elseif return_type == "ComplexF"
        tmp = 525
    elseif return_type == "ComplexI" || return_type == "Number"
        tmp = 550
    else 
        println(string("wrong_type = ", return_type))
    end
    return tmp
end

function type_to_var(return_type)
    num = type_to_random(return_type)
    rand_n = rand(0:num)
    if rand_n <= 75
        tmp1::Bool = rand(Bool)
        return tmp1
    elseif rand_n <= 100
        tmp2::Int8 = rand(Int8)
        return tmp2
    elseif rand_n <= 125
        tmp3::UInt8 = rand(UInt8)
        return tmp3
    elseif rand_n <= 150
        tmp4::Int16 = rand(Int16)
        return tmp4
    elseif rand_n <= 175
        tmp5::UInt16 = rand(UInt16)
        return tmp5
    elseif rand_n <= 200
        tmp6::Int32 = rand(Int32)
        return tmp6
    elseif rand_n <= 225
        tmp7::UInt32 = rand(UInt32)
        return tmp7
    elseif rand_n <= 250
        tmp8::Int64 = rand(Int64)
        return tmp8
    elseif rand_n <= 275
        tmp9::UInt64 = rand(UInt64)
        return tmp9
    elseif rand_n <= 300
        tmp10::Int128 = rand(Int128)
        return tmp10
    elseif rand_n <= 325
        tmp11::UInt128 = rand(UInt128)
        return tmp11
    elseif rand_n <= 350
        bigTmp = rand(1:6)
        tmp12::BigInt = rand(big.(1:6))
        return tmp12
    elseif rand_n <= 375
        tmp13::Rational = rationalize(rand(Float16))
        return tmp13
    elseif rand_n <= 400
        tmp14::Irrational = pi
        return tmp14
    elseif rand_n <= 425
        tmp15::Float16 = rand(Float16)
        return tmp15
    elseif rand_n <= 450
        tmp16::Float32 = rand(Float32)
        return tmp16
    elseif rand_n <= 475
        tmp17::Float64 = rand(Float64)
        return tmp17
    elseif rand_n <= 500
        bigTmp = rand(1:6)
        tmp18::BigFloat = rand(big.(1:6))
        return tmp18
    elseif rand_n <= 525
        tmp19::Complex = rand(Complex{Int16})
        return tmp19
    elseif rand_n <= 550
        tmp20::Complex = rand(Complex{Float16})
        return tmp20
    end
end

#Note couldn't get fixed to show up 