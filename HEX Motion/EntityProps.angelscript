class EntityProps
{
	EntityProps(){}
	EntityProps(float _scale, FloatColor _color, float _angle)
	{	
		m_scale = _scale;
		m_color = _color;
		m_angle = _angle;
	}
	float m_scale;
	FloatColor m_color;
	float m_angle;
}

EntityProps interpolate(EntityProps a, EntityProps p, float bias)
{
	return EntityProps(interpolate(a.m_scale, b.m_scale,bias), interpolate(a.m_color, b.m_color,bias), interpolate(a.m_color, b.m_color,bias));
}

void setEntityProps(ETHEntity@ thisEntity, EntityProps props)
{
	thisEntity.Scale(props.m_scale);
	thisEntity.SetColor(props.m_color.getVector3());
}